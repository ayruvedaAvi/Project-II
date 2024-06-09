const express = require('express');
const router = express.Router();
const authenticateUser = require('../middleware/authentication');
const {
  getSingleUser,
  showCurrentUser,
  updateUser,
  updateUserPassword,
  passwordVerify
  
} = require('../controllers/userController');


router.route('/showMe').get(authenticateUser, showCurrentUser);
router.route('/updateUser').patch(authenticateUser, updateUser);
router.route('/updateUserPassword').post(authenticateUser, updateUserPassword)
router.route('/verify').post(authenticateUser,passwordVerify)
router.route('/:id').get(authenticateUser, getSingleUser);

module.exports = router;
