const { GoogleAuth } = require('google-auth-library');
const path = require('path');

const SCOPES = ['https://www.googleapis.com/auth/firebase.messaging'];
const keyPath = path.resolve(__dirname, '../shrami-329b1-firebase-adminsdk-9lt4u-0d45533262.json');

const getAccessToken = async () => {
  try {
    const auth = new GoogleAuth({
      keyFile: keyPath,
      scopes: SCOPES,
    });

    const client = await auth.getClient();
    const tokenResponse = await client.getAccessToken();
    console.log('Token Response:', tokenResponse);
    return tokenResponse.token;
  } catch (error) {
    console.error('Error obtaining access token:', error);
    throw error;
  }
};

module.exports = getAccessToken;
