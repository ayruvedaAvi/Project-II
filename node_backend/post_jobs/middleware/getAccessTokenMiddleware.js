const axios = require('axios');
const getAccessToken = require('../utils/getAccessToken');

const attachTokenInterceptor = async (req, res, next) => {
  try {
    const oAuth2Token = await getAccessToken();
    console.log('Access Token:', oAuth2Token);

    axios.interceptors.request.use(config => {
      config.headers.Authorization = `Bearer ${oAuth2Token}`;
      return config;
    });

    next();
  } catch (error) {
    console.error('Error attaching token interceptor:', error);
    res.status(500).send({ message: 'Failed to attach token interceptor', error: error.message });
  }
};

module.exports = attachTokenInterceptor;
