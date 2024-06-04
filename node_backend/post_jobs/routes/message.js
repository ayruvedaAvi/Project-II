const express = require('express');
const router = express.Router();

const messageController = require('../controllers/message')
const notificationController=require('../controllers/notification')
const auth = require('../middleware/authentication');

router.post('/sendMessage',auth, messageController.sendMessage)
router.get('/myMessages',auth, messageController.myMessages)
router.get('/send-test-notification', auth,notificationController)

module.exports = router