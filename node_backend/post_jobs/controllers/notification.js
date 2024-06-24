require('dotenv').config();
const axios = require('axios');

const firebaseUrl = process.env.FIREBASE_URL;

const sendNotification = async (req, res) => {
  try {
    console.log('Request received:', req.body);

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

    console.log('Sending request to Firebase with message:', message);

    const response = await axios.post(firebaseUrl, message);
    console.log('Response:', response.data);
    res.status(200).send({ message: 'Notification sent successfully', data: response.data });
  } catch (error) {
    console.error('Error:', error.response ? error.response.data : error.message);
    res.status(500).send({ message: 'Failed to send notification', error: error.response ? error.response.data : error.message });
  }
};

module.exports = sendNotification;
