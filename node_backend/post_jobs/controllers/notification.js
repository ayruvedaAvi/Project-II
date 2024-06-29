require('dotenv').config();
const axios = require('axios');
const FcmToken = require('../models/fcmToken');
const firebaseUrl = process.env.FIREBASE_URL 

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
    const promises = allTokens.map(token => {
      const tokenMessage = { ...message, message: { ...message.message, token: token } };
      console.log('Sending request to Firebase with message:', tokenMessage);
      return axios.post(firebaseUrl, tokenMessage);
    });

    const responses = await Promise.all(promises);
    const successResponses = responses.filter(response => response.status === 200);

    res.status(200).send({ message: 'Notifications sent successfully', data: successResponses.map(response => response.data) });
  } catch (error) {
    console.error('Error:', error.response ? error.response.data : error.message);
    res.status(500).send({ message: 'Failed to send notifications', error: error.response ? error.response.data : error.message });
  }
};

module.exports = { sendNotification, storeFcmToken };
