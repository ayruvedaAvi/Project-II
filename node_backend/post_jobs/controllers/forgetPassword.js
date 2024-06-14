const User = require('../models/User');
const { StatusCodes } = require('http-status-codes');
const CustomError = require('../errors');

let otpStore = {};
let tempUserStore = {};
let otpVerifiedUser = null;

const emailVerification = async (req, res) => {
    const { email } = req.body;

    if (!email) {
        throw new CustomError.BadRequestError('Email must be provided');
    }

    try {
        const existingUser = await User.findOne({ email });

        if (!existingUser) {
            throw new CustomError.BadRequestError('Email not registered');
        }

        const otp = Math.floor(100000 + Math.random() * 900000).toString();
        const userId = existingUser._id.toString();
        console.log(userId);

        otpStore[otp] = userId;
        tempUserStore[userId] = existingUser;

        console.log(`OTP for ${email}: ${otp}`);

        return res.status(StatusCodes.OK).json({ msg: 'OTP sent successfully', otp });
    } catch (error) {
        console.error('Error in email verification:', error);
        throw new CustomError.BadRequestError('Failed to process request');
    }
};

const otpVerify = async (req, res) => {
    const { otp } = req.body;

    try {
        if (!otp) {
            throw new CustomError.BadRequestError('OTP must be provided');
        }

        const userId = otpStore[otp];

        if (!userId) {
            console.log('Stored OTP:', otpStore);
            throw new CustomError.BadRequestError('Invalid or expired OTP');
        }

        delete otpStore[otp];
        otpVerifiedUser = userId;

        return res.status(StatusCodes.OK).json({ msg: 'OTP verified successfully', verified: true });
    } catch (error) {
        console.error('Error in OTP verification:', error);
        throw new CustomError.BadRequestError('Failed to process request');
    }
};

const forgetPassword = async (req, res) => {
    try {
        const { newPassword, confirmPassword } = req.body;

        if (!otpVerifiedUser) {
            throw new CustomError.BadRequestError('Invalid OTP');
        }

        if (!(newPassword && confirmPassword)) {
            throw new CustomError.BadRequestError('Please provide all required values');
        }

        if (newPassword !== confirmPassword) {
            throw new CustomError.BadRequestError('Passwords do not match');
        }

        if (newPassword.length < 6) {
            throw new CustomError.BadRequestError('Password should be at least 6 characters');
        }

        const user = tempUserStore[otpVerifiedUser];

        if (!user) {
            throw new CustomError.BadRequestError('No registration details found for this user');
        }

        user.password = newPassword;
        await user.save();

        delete tempUserStore[otpVerifiedUser];
        otpVerifiedUser = null;

        return res.status(StatusCodes.OK).json({ msg: 'Password updated successfully' });
    } catch (error) {
        console.error('Error in password reset:', error);
        throw new CustomError.BadRequestError('Failed to process request');
    }
};

module.exports = {
    emailVerification,
    otpVerify,
    forgetPassword,
};
