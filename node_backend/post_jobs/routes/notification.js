const express = require('express');
const router = express.Router();
const { sendNotification, storeFcmToken } = require('../controllers/notification');
const attachTokenInterceptor = require('../middleware/getAccessTokenMiddleware');

// Use the middleware to attach the token interceptor
router.post('/store-fcm-token', storeFcmToken);
router.post('/send-notification', attachTokenInterceptor, sendNotification);

module.exports = router;
