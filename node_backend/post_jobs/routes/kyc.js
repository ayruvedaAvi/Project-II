const express = require('express');
const router = express.Router();
const authenticateUser = require('../middleware/authentication');
const  addkyc  = require('../controllers/kyc');

router.route('/').post(authenticateUser, addkyc);

 module.exports = router;