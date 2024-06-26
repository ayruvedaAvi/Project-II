
const axios = require('axios');
const getAccessToken = require('../utils/getAccessToken');

const attachTokenInterceptor = async () => {
  const oAuth2Token = await getAccessToken();

  axios.interceptors.request.use(config => {
    config.headers.Authorization = `Bearer ${oAuth2Token}`;
    return config;
  });
};

module.exports = attachTokenInterceptor;
