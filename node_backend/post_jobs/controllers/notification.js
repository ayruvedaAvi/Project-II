require('dotenv').config();
const axios = require('axios');
const FcmToken = require('../models/fcmToken');
const firebaseUrl = process.env.FIREBASE_URL 
const Notification = require('../models/notification');
const getAccessToken = require('../utils/getAccessToken');
const User = require('../models/User');
const mongoose = require('mongoose');
const { BadRequestError } = require('../errors');
const Job = require('../models/Job');

const storeFcmToken = async (req, res) => {
  console.log('Request received to store FCM token:', req.body);

  const { registrationToken } = req.body;
  const userId = req.user.userId;

  if (!registrationToken) {
    return res.status(400).send({ message: 'Registration token is required' });
  }

  if (!userId) {
    return res.status(400).send({ message: 'User ID is required' });
  }

  try {
    let fcmToken = await FcmToken.findOne({ userId });

    if (fcmToken) {
      if (!fcmToken.registrationToken.includes(registrationToken)) {
        fcmToken.registrationToken.push(registrationToken);
        await fcmToken.save();
      }
    } else {
      fcmToken = new FcmToken({ userId, registrationToken: [registrationToken] });
      await fcmToken.save();
    }

    res.status(200).send({ message: 'FCM token stored successfully' });
  } catch (error) {
    console.error('Error:', error.message);
    res.status(500).send({ message: 'Failed to store FCM token', error: error.message });
  }
};

const sendNotification = async (req, res) => {
  try {
    const { title, body } = req.body;

    if (!title || !body) {
      return res.status(400).send({ message: 'Title and body are required' });
    }

    const tokens = await FcmToken.find({});
    const allTokens = tokens.reduce((acc, token) => acc.concat(token.registrationToken), []);

    if (allTokens.length === 0) {
      return res.status(400).send({ message: 'No FCM tokens found in the database' });
    }

    const message = {
      message: {
        notification: {
          body: body,
          title: title
        }
      }
    };

    const oAuth2Token = await getAccessToken();

    const promises = allTokens.map(token => {
      const tokenMessage = { ...message, message: { ...message.message, token: token } };
      console.log('Sending request to Firebase with message:', tokenMessage);

      return axios.post(firebaseUrl, tokenMessage, {
        headers: {
          Authorization: `Bearer ${oAuth2Token}`
        }
      });
    });

    const responses = await Promise.all(promises);
    const successResponses = responses.filter(response => response.status === 200);
    const notificationPromises = tokens.map(async (token) => {
      const notification = new Notification({
        userId: token.userId,
        title: title,
        body: body
      });
      await notification.save();
    });
    await Promise.all(notificationPromises);

    res.status(200).send({ message: 'Notifications sent successfully and stored in the database', data: successResponses.map(response => response.data) });
  } catch (error) {
    console.error('Error:', error.response ? error.response.data : error.message);
    res.status(500).send({ message: 'Failed to send notifications', error: error.response ? error.response.data : error.message });
  }
};


const sendNotificationOfJobPosted = async (title, body, posterUserId) => {
  try {
    // Fetch all users excluding the poster
    const allUsers = await User.find({ _id: { $ne: posterUserId }, isActive: true }).exec();

    if (!allUsers) {
      throw new Error('Failed to fetch users');
    }

    const userIds = allUsers.map(user => user._id);
    const tokens = await FcmToken.find({ userId: { $in: userIds } }).exec();
    
    if (!tokens) {
      throw new Error('Failed to fetch tokens');
    }

    const allTokens = tokens.reduce((acc, token) => acc.concat(token.registrationToken), []);

    if (allTokens.length === 0) {
      throw new Error('No FCM tokens found for active users');
    }

    const message = {
      notification: {
        title,
        body,
      }
    };

    const oAuth2Token = await getAccessToken();

    if (!oAuth2Token) {
      throw new Error('Failed to get OAuth2 token');
    }

    const promises = allTokens.map(token => {
      const tokenMessage = { ...message, token };
      console.log('Sending request to Firebase with message:', JSON.stringify(tokenMessage, null, 2));

      return axios.post(firebaseUrl, { message: tokenMessage }, {
        headers: {
          Authorization: `Bearer ${oAuth2Token}`
        }
      });
    });

    const responses = await Promise.all(promises);

    responses.forEach(response => {
      if (response.status !== 200) {
        throw new Error(`Failed to send notification: ${response.statusText}`);
      }
    });

    const notificationPromises = tokens.map(token => {
      const notification = new Notification({
        userId: token.userId,
        title,
        body,
      });
      return notification.save();
    });

    await Promise.all(notificationPromises);

    console.log('Notifications sent successfully and stored in the database');
  } catch (error) {
    console.error('Error sending notifications:', error.message);
    throw new Error('Failed to send notifications');
  }
};


const sendNotificationToUser = async (title, body, userId,jobId) => {
  try {
    if (!title || !body) {
      throw new Error('Title and body are required');
    }

    const user = await User.findOne({ _id: userId, isActive: true }).exec();

    if (!user) {
      throw new Error('User not found or not active');
    }

    const tokenDoc = await FcmToken.findOne({ userId }).exec();

    if (!tokenDoc || tokenDoc.registrationToken.length === 0) {
      throw new Error('No FCM tokens found for user');
    }

    const registrationTokens = tokenDoc.registrationToken;
    const oAuth2Token = await getAccessToken();

    if (!oAuth2Token) {
      throw new Error('Failed to get OAuth2 token');
    }

    const notificationPromises = registrationTokens.map(async (token) => {
      const message = {
        message: {
          notification: {
            title,
            body,
          },
          token
        }
      };

      try {
        const response = await axios.post(firebaseUrl, message, {
          headers: {
            Authorization: `Bearer ${oAuth2Token}`,
            'Content-Type': 'application/json'
          }
        });

        if (response.status !== 200) {
          console.error(`Failed to send notification to token ${token}: ${response.statusText}`);
        }
      } catch (error) {
        console.error(`Error sending notification to token ${token}: ${error.message}`);
      }
    });

    await Promise.all(notificationPromises);

    const notification = new Notification({
      userId,
      title,
      body,
      jobId
    });
    await notification.save();

    console.log('Notifications sent successfully to all tokens and stored in the database');
  } catch (error) {
    console.error('Error sending notifications:', error.message);
    throw new BadRequestError('Failed to send notifications');
  }
};
const getUserNotifications = async (req, res) => {
  try {
    const userId = req.user.userId;

    if (!userId) {
      return res.status(400).send({ message: 'User ID is required' });
    }

    const notifications = await Notification.find({ userId }).sort({ createdAt: -1 }).exec();

    res.status(200).send({ notifications });
  } catch (error) {
    console.error('Error fetching notifications:', error.message);
    res.status(500).send({ message: 'Failed to fetch notifications', error: error.message });
  }
};




module.exports = { sendNotification, storeFcmToken,sendNotificationOfJobPosted,sendNotificationToUser,getUserNotifications };