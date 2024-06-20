const express = require('express');
const router = express.Router();
const sendNotification = require('../controllers/notification');

// Change the route method from get to post
router.route('/singleNotification').post(sendNotification);

module.exports = router;
