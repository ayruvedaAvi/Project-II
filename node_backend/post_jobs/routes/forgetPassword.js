const express = require('express');
const router = express.Router();
const { emailVerification,
    otpVerify,
    forgetPassword }=require('../controllers/forgetPassword')

router.route('/verifyemail').post(emailVerification)
router.route('/verify').post(otpVerify)
router.route('/resetPassword').patch( forgetPassword )

module.exports=router