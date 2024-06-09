const User = require('../models/User');
const mongoose = require('mongoose');
const { StatusCodes } = require('http-status-codes');
const CustomError = require('../errors');
const {createJWT}= require('../utils');
const twilio = require('twilio');

const getAllUsers = async (req, res) => {
  console.log(req.user);
  const users = await User.find({ role: 'user' }).select('-password');
  res.status(StatusCodes.OK).json({ users });
};

const getSingleUser = async (req, res) => {
  const user = await User.findOne({ _id: req.params.id }).select('-password');
  if (!user) {
    throw new CustomError.NotFoundError(`No user with id : ${req.params.id}`);
  }
  res.status(StatusCodes.OK).json({ user });
};

const showCurrentUser = async (req, res) => {
  res.status(StatusCodes.OK).json({ user: req.user });
};



const updateUser = async (req, res) => {
  const {name, lastName, profilePicture, phoneNumber } = req.body;
  const userId = req.user.userId;
  const phoneNumberRegex = /^\+977\s\d{10}$/;
    const isValidPhoneNumber = phoneNumberRegex.test(phoneNumber);

  console.log('Received request to update user with ID:', userId);

  if (!userId) {
    throw new CustomError.BadRequestError('User ID is missing in the request');
  }

  if (!mongoose.Types.ObjectId.isValid(userId)) {
    throw new CustomError.BadRequestError('Invalid user ID format');
  }

  const user = await User.findById(userId);

  if (!user) {
    console.log(`User not found with ID: ${userId}`);
    throw new CustomError.NotFoundError(`No user found with ID: ${userId}`);
  }

  if (user._id.toString() !== userId) {
    throw new CustomError.UnauthorizedError('Not authorized to update this profile');
  }

  // Update user fields only if provided
  user.name = name || user.name;
  user.lastName = lastName || user.lastName;
  user.profilePicture = profilePicture || user.profilePicture;
  if (isValidPhoneNumber) {
    user.phoneNumber = phoneNumber || user.phoneNumber;
  }else{
  throw new CustomError.BadRequestError('Invalid phone number format');
  }

  await user.save();

  const tokenUser = {
    name: user.name,
    lastName: user.lastName,
    userId: user._id,
    role: user.role,
    profilePicture: user.profilePicture,
    phoneNumber: user.phoneNumber,
  };

  const token = createJWT({ payload: tokenUser });

  res.status(StatusCodes.OK).json({ user: tokenUser, token });
};




const client = twilio(process.env.Account_SID, process.env.Auth_Token);
const otpStore = {};
const tempUserStore = {};

const updateUserPassword = async (req, res) => {
  const { oldPassword, newPassword } = req.body;
  const phoneNumber = req.user.phoneNumber; // Get phone number from the request object

  if (!oldPassword || !newPassword) {
      throw new CustomError.BadRequestError('Please provide both values');
  }

  if (oldPassword === newPassword) {
      throw new CustomError.BadRequestError('Old password and new password cannot be the same');
  }

  const otp = Math.floor(100000 + Math.random() * 900000).toString();
  otpStore[otp] = phoneNumber;
  tempUserStore[phoneNumber] = { oldPassword, newPassword };

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

  res.status(StatusCodes.CREATED).json({ msg: 'OTP sent to phone number. Please verify to complete the update.' });
};

const passwordVerify = async (req, res) => {
  const { otp } = req.body;
  const phoneNumber = req.user.phoneNumber; // Get phone number from the request object

  const storedPhoneNumber = otpStore[otp];
  if (!storedPhoneNumber || storedPhoneNumber !== phoneNumber) {
      throw new CustomError.BadRequestError('Invalid or expired OTP');
  }

  const userDetails = tempUserStore[phoneNumber];
  if (!userDetails) {
      throw new CustomError.BadRequestError('No registration details found for this phone number');
  }

  const { oldPassword, newPassword } = userDetails;

  const user = await User.findOne({ _id: req.user.userId });
  if (!user) {
      throw new CustomError.NotFoundError('User not found');
  }

  const isPasswordCorrect = await user.comparePassword(oldPassword);
  if (!isPasswordCorrect) {
      throw new CustomError.UnauthenticatedError('Invalid Credentials');
  }

  user.password = newPassword;
  await user.save();

  delete otpStore[otp];
  delete tempUserStore[phoneNumber];

  res.status(StatusCodes.OK).json({ msg: 'Success! Password Updated.' });
};

module.exports = {
  getAllUsers,
  getSingleUser,
  showCurrentUser,
  updateUser,
  updateUserPassword,
  passwordVerify
};


