require('dotenv').config();
const axios = require('axios');

const firebaseUrl = process.env.FIREBASE_URL;

const sendNotification = async (req, res) => {
  try {
    const { title, body, registrationToken } = req.body;

    const message = {
      "message": {
        "token": registrationToken,
        "notification": {
          "body": body,
          "title": title
        }
      }
    };

    const response = await axios.post(firebaseUrl, message);
    console.log('Response:', response.data);
    res.status(200).send({ message: 'Notification sent successfully', data: response.data });
  } catch (error) {
    console.error('Error:', error);
    res.status(500).send({ message: 'Failed to send notification' });
  }
};

module.exports = sendNotification;