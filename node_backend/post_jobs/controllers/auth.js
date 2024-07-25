const jwt = require('jsonwebtoken');
const User = require('../models/User');
const CustomError=require('../errors')
const { createJWT }=require('../utils')
require('dotenv').config();
const twilio = require('twilio');
const { StatusCodes } = require('http-status-codes');
const crypto = require('crypto');
const { ProfilePicture } = require('./userController');
const { tokenBlacklist } = require('../middleware/authentication');

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
    user.isActive = true;
    await user.save();
  
    delete otpStore[otp];
    delete tempUserStore[phoneNumber];
  
    const tokenUser = { name: user.name, lastName: user.lastName, profilePicture: user.profilePicture, userId: user._id, role: user.role, phoneNumber: user.phoneNumber };
    const token = createJWT({ payload: tokenUser });
  
    res.status(StatusCodes.OK).json({ msg: 'Phone number verified successfully. Registration complete.', user: tokenUser, token });
  };
  const login = async (req, res) => {
    const { phoneNumber, email, password } = req.body;
    if (!(phoneNumber || email) || !password) {
      throw new CustomError.BadRequestError("Invalid phone number or email and password");
    }
  
    const user = await User.findOne({ email }) || await User.findOne({ phoneNumber });
    if (!user) {
      throw new CustomError.UnauthenticatedError("Invalid user");
    }
  
    const isPasswordCorrect = await user.comparePassword(password);
    if (!isPasswordCorrect) {
      throw new CustomError.UnauthenticatedError("Invalid password");
    }
  
   
    user.isActive = true;
    await user.save();
  
    const tokenUser = { name: user.name, lastName: user.lastName, profilePicture: user.profilePicture, userId: user._id, role: user.role, phoneNumber: user.phoneNumber };
    const token = createJWT({ payload: tokenUser });
  
    res.status(StatusCodes.CREATED).json({ user: tokenUser, token });
  };



  const logout = async (req, res) => {
    const authHeader = req.headers.authorization;
    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      return res.status(StatusCodes.BAD_REQUEST).json({ msg: 'No token provided' });
    }
  
    const token = authHeader.split(' ')[1];
    try {
      const decoded = jwt.verify(token, process.env.JWT_SECRET);
  
   
      tokenBlacklist.add(token);
  
      const userId = decoded.userId;
      const user = await User.findById(userId);
      if (!user) {
        return res.status(StatusCodes.UNAUTHORIZED).json({ msg: 'User not found' });
      }
  
      user.isActive = false;
      await user.save();
  
      return res.status(StatusCodes.OK).json({ msg: 'Logged out successfully' });
    } catch (error) {
      console.error('JWT Verification Error:', error);
      return res.status(StatusCodes.UNAUTHORIZED).json({ msg: 'Invalid or expired token' });
    }
  };

module.exports = {
    register,
    verify,
    login,
    logout,

  };