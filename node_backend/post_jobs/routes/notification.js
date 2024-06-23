// In your route setup file
const express = require('express');
const router = express.Router();
const sendNotificationController = require('../controllers/notification');
const attachTokenInterceptor = require('../middleware/getAccessTokenMiddleware');

router.post('/singleNotification', attachTokenInterceptor, sendNotificationController);

module.exports = router;
