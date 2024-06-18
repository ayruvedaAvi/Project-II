const axios = require('axios');
const { google } = require('googleapis');
const path = require('path');

const firebaseUrl = "https://fcm.googleapis.com/v1/projects/shrami-329b1/messages:send";
const SCOPES = ['https://www.googleapis.com/auth/firebase.messaging']; // Define the required scopes

// Function to get the access token
function getAccessToken() {
  return new Promise(function(resolve, reject) {
    const keyPath = path.resolve(__dirname, '../shrami-329b1-firebase-adminsdk-9lt4u-0d45533262.json'); // Adjust the path to your JSON file
    const key = require(keyPath);
    const jwtClient = new google.auth.JWT(
      key.client_email,
      null,
      key.private_key,
      SCOPES,
      null
    );
    jwtClient.authorize(function(err, tokens) {
      if (err) {
        reject(err);
        return;
      }
      resolve(tokens.access_token);
    });
  });
}

const sendNotification = async (req, res) => {
  try {
    const { title, body, registrationToken } = req.body; // Destructure the required fields from req.body

    // Obtain the OAuth2 token
    const oAuth2Token = await getAccessToken();

    const message = {
      "message": {
        "token": registrationToken,
        "notification": {
          "body": body,
          "title": title
        }
      }
    };

    const config = {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + oAuth2Token
      }
    };

    const response = await axios.post(firebaseUrl, message, config);
    console.log('Response:', response.data);
    res.status(200).send({ message: 'Notification sent successfully', data: response.data });

  } catch (error) {
    console.error('Error:', error);
    res.status(500).send({ message: 'Failed to send notification' });
  }
};

module.exports = sendNotification;
