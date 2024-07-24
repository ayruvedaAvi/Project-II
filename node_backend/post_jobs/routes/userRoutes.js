const express = require('express');
const router = express.Router();
const {checkBlacklist,auth} = require('../middleware/authentication');
const {  updateUser,updateUserPassword,passwordVerify,ProfilePicture} = require('../controllers/userController');

router.route('/updateUser').patch(auth,checkBlacklist, updateUser);
router.route('/updateUserPassword').patch(auth,checkBlacklist, updateUserPassword)
router.route('/verify').post(auth,checkBlacklist,passwordVerify)
router.route('/profilePicture').post(auth,checkBlacklist,ProfilePicture)

module.exports = router;
