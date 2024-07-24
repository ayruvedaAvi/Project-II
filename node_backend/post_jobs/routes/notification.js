const express = require('express');
const router = express.Router();
const { sendNotification, storeFcmToken } = require('../controllers/notification');
const attachTokenInterceptor = require('../middleware/getAccessTokenMiddleware');
const auth = require('../middleware/authentication');

// Use the middleware to attach the token interceptor
router.post('/store-fcm-token',auth, storeFcmToken);
router.post('/send-notification', attachTokenInterceptor, sendNotification);

module.exports = router;
