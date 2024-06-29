require('dotenv').config();
const axios = require('axios');
const FcmToken = require('../models/fcmToken');
const firebaseUrl = process.env.FIREBASE_URL 
const Notification = require('../models/notification');
const getAccessToken = require('../utils/getAccessToken');

const storeFcmToken = async (req, res) => {
  try {
    console.log('Request received to store FCM token:', req.body);

    const { registrationToken } = req.body;
    const userId = req.user.userId; 

    if (!registrationToken) {
      return res.status(400).send({ message: 'Registration token is required' });
    }

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
const sendNotificationOfJobPosted = async (title, body, jobLocation, posterUserId) => {
  try {
    const nearbyUsers = await User.aggregate([
      {
        $geoNear: {
          near: {
            type: 'Point',
            coordinates: jobLocation.coordinates
          },
          distanceField: 'dist.calculated',
          maxDistance: 5000, // 5 km in meters
          spherical: true
        }
      },
      {
        $match: {
          _id: { $ne: mongoose.Types.ObjectId(posterUserId) }
        }
      }
    ]);

    const nearbyUserIds = nearbyUsers.map(user => user._id);
    const tokens = await FcmToken.find({ userId: { $in: nearbyUserIds } });
    const allTokens = tokens.reduce((acc, token) => acc.concat(token.registrationToken), []);

    if (allTokens.length === 0) {
      console.error('No FCM tokens found for nearby users');
      return;
    }

    const message = {
      notification: {
        body: body,
        title: title
      }
    };

    const oAuth2Token = await getAccessToken();

    const promises = allTokens.map(token => {
      const tokenMessage = { ...message, token: token };
      console.log('Sending request to Firebase with message:', JSON.stringify(tokenMessage, null, 2));

      return axios.post(firebaseUrl, { message: tokenMessage }, {
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

    console.log('Notifications sent successfully and stored in the database');
  } catch (error) {
    console.error('Failed to send notifications:', error.response ? error.response.data : error.message);
  }
};

module.exports = { sendNotification, storeFcmToken,sendNotificationOfJobPosted };
