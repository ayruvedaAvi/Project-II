const express = require('express');
const router = express.Router();

const {
    createPrivateChat,
    createGroupChat,
    myChats,
    chatById
}= require('../controllers/chat')
const auth = require('../middleware/authentication');

router.post('/createPrivateChat',auth,createPrivateChat);
router.post('/createGroupChat',auth, createGroupChat);
router.get('/myChats',auth,myChats);
router.get('/chatById',auth,chatById);

module.exports = router