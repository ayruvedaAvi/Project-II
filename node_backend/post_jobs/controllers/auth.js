const User = require('../models/User');
const CustomError=require('../errors')
const { createJWT }=require('../utils')
require('dotenv').config();
const twilio = require('twilio');
const { StatusCodes } = require('http-status-codes');


const client = twilio(process.env.Account_SID, process.env.Auth_Token);
const otpStore = {};
const tempUserStore = {}; 

const register = async (req, res) => {
    const { name, lastName, phoneNumber, email, password } = req.body;
    const phoneNumberRegex = /^\+977\s\d{10}$/;
    const isValidPhoneNumber = phoneNumberRegex.test(phoneNumber);
    console.log(`${phoneNumber} is valid: ${isValidPhoneNumber}`);

    if (!isValidPhoneNumber) {
        throw new CustomError.BadRequestError('Invalid phone number format');
    }

    if (email) {
        const existingUserWithEmail = await User.findOne({ email });
        if (existingUserWithEmail) {
            throw new CustomError.BadRequestError('Email already registered');
        }
    }

    // Commented out for testing phase
    // const existingUserWithPhoneNumber = await User.findOne({ phoneNumber });
    // if (existingUserWithPhoneNumber) {
    //     throw new CustomError.BadRequestError('Phone number already registered');
    // }

    const otp = Math.floor(100000 + Math.random() * 900000).toString();
    otpStore[otp] = phoneNumber;
    tempUserStore[phoneNumber] = { name, lastName, email, password };

    try {
        await client.messages.create({
            body: `Your OTP code is ${otp}`,
            from: process.env.TWILIO_PHONE_NUMBER,
            to: phoneNumber,
        });
    } catch (error) {
        console.error('Failed to send OTP:', error);
        throw new CustomError.BadRequestError('Failed to send OTP');
    }

    res.status(StatusCodes.CREATED).json({ msg: 'OTP sent to phone number. Please verify to complete registration.' });
};

const verify = async (req, res) => {
    const { otp } = req.body;

    const phoneNumber = otpStore[otp];
    if (!phoneNumber) {
        throw new CustomError.BadRequestError('Invalid or expired OTP');
    }

    const userDetails = tempUserStore[phoneNumber];
    if (!userDetails) {
        throw new CustomError.BadRequestError('No registration details found for this phone number');
    }

    const isFirstUser = (await User.countDocuments({})) === 0;
    const role = isFirstUser ? 'WorkProvider' : 'Worker';

    const user = await User.create({ ...userDetails, phoneNumber, role, isActive: true });

    delete otpStore[otp];
    delete tempUserStore[phoneNumber];

    const tokenUser = { name: user.name, lastName: user.lastName, userId: user._id, role: user.role };
    const token = createJWT({ payload: tokenUser });

    res.status(StatusCodes.OK).json({ msg: 'Phone number verified successfully. Registration complete.', user: tokenUser, token });
};
const login = async (req, res) => {
    const { phoneNumber, email, password } = req.body;
    if (!(phoneNumber || email) || !password) {
        throw new CustomError.BadRequestError("Invalid phoneNumber and password");
    }
    const user = await User.findOne({ email }) || await User.findOne({ phoneNumber });
    if (!user) {
        throw new CustomError.UnauthenticatedError("Invalid user");
    }
    const isPasswordCorrect = await user.comparePassword(password);
    if (!isPasswordCorrect) {
        throw new CustomError.UnauthenticatedError("Invalid password");
    }
    if (!user.isActive) {
        throw new CustomError.UnauthenticatedError("User not verified");
    }
    const tokenUser = { name: user.name, lastName:user.lastName,userId: user._id, role: user.role };
    const token = createJWT({ payload: tokenUser });
    res.status(StatusCodes.CREATED).json({ user: tokenUser, token });
};

const logout = async (req, res) => {
    res.cookie('token','logout',{
        httpOnly:true,
        expires:new Date(Date.now()+5*1000),
    })
    res.status(StatusCodes.OK).json({ msg: "log out" });
};
// const updateUserProfile = async (req, res) => {
//     const { name, lastName, email, phoneNumber, oldPassword, newPassword } = req.body;
//     const authenticatedUserId = req.user.userId;
  
//     // Fetch the user from the database based on the user ID
//     const user = await User.findById(authenticatedUserId);
  
//     // Verify if the user exists
//     if (!user) {
//       throw new CustomError.NotFoundError('User not found');
//     }
  
//     // Verify if the authenticated user is the same as the profile owner
//     if (authenticatedUserId !== req.body.userId) {
//       throw new CustomError.UnauthenticatedError('You are not authorized to update this user');
//     }
  
//     // Update user's profile fields if provided
//     if (name !== undefined) {
//       user.name = name;
//     }
//     if (lastName !== undefined) {
//       user.lastName = lastName;
//     }
//     if (email !== undefined) {
//       user.email = email;
//     }
//     if (phoneNumber !== undefined) {
//       user.phoneNumber = phoneNumber;
//     }
  
//     // Update user's password if both oldPassword and newPassword are provided
//     if (oldPassword !== undefined && newPassword !== undefined) {
//       // Verify the old password
//       const isPasswordCorrect = await user.comparePassword(oldPassword);
//       if (!isPasswordCorrect) {
//         throw new CustomError.UnauthenticatedError('Invalid Credentials');
//       }
  
//       // Update the password
//       user.password = newPassword;
//     } else if (oldPassword !== undefined || newPassword !== undefined) {
//       // If only one of oldPassword or newPassword is provided, throw an error
//       throw new CustomError.BadRequestError('Please provide both old and new passwords');
//     }
  
//     // Save the updated user
//     await user.save();
  
//     res.status(StatusCodes.OK).json({ user, msg: 'User profile updated successfully' });
//   };
  

module.exports = {
  register,
  verify,
  login,
  logout,

};