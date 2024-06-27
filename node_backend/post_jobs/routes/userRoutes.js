const express = require('express');
const router = express.Router();
const authenticateUser = require('../middleware/authentication');
const {  updateUser,updateUserPassword,passwordVerify,ProfilePicture} = require('../controllers/userController');

router.route('/updateUser').patch(authenticateUser, updateUser);
router.route('/updateUserPassword').patch(authenticateUser, updateUserPassword)
router.route('/verify').post(authenticateUser,passwordVerify)
router.route('/profilePicture').post(authenticateUser,ProfilePicture)

module.exports = router;
