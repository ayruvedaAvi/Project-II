const express = require('express');
const router = express.Router();
const { sendNotification, storeFcmToken,getUserNotifications  } = require('../controllers/notification');
const attachTokenInterceptor = require('../middleware/getAccessTokenMiddleware');
const {checkBlacklist,auth} = require('../middleware/authentication');

// Use the middleware to attach the token interceptor
router.post('/store-fcm-token',auth,checkBlacklist, storeFcmToken);
router.post('/send-notification', attachTokenInterceptor, sendNotification);
router.get('/getUserNotifications',auth,checkBlacklist,getUserNotifications);

module.exports = router;
 