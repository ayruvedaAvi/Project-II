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
    const { name, phoneNumber, email, password } = req.body;
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

    // const existingUserWithPhoneNumber = await User.findOne({ phoneNumber });
    // if (existingUserWithPhoneNumber) {
    //     throw new CustomError.BadRequestError('Phone number already registered');
    // }

    const otp = Math.floor(100000 + Math.random() * 900000).toString();
    otpStore[otp] = phoneNumber;
    tempUserStore[phoneNumber] = { name, email, password };

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

    const tokenUser = { name: user.name, userId: user._id, role: user.role };
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
    const tokenUser = { name: user.name, userId: user._id, role: user.role };
    const token = createJWT({ payload: tokenUser });
    res.status(StatusCodes.CREATED).json({ user: tokenUser, token });
};

const logout = async (req, res) => {
    res.cookie('token','logout',{
        httpOnly:true,
        expires:new Date(Date.now()+5*1000),
    })
    res.status(StatusCodes.OK).json({ msg: "log out" });
    console.log("logout");
};


const updateUser = async (req, res) => {
  const { email, name, lastName, location } = req.body;
  if (!email || !name || !lastName || !location) {
    throw new BadRequest('Please provide all values');
  }
  const user = await User.findOne({ _id: req.user.userId });

  user.email = email;
  user.name = name;
  user.lastName = lastName;
  user.location = location;

  await user.save();
  const token = user.createJWT();
  res.status(StatusCodes.OK).json({
    user: {
      email: user.email,
      lastName: user.lastName,
      location: user.location,
      name: user.name,
      token,
    },
  });
};

module.exports = {
  register,
  verify,
  login,
  logout,
  updateUser,
};
