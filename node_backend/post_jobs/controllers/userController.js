const User = require('../models/User');
const mongoose = require('mongoose');
const { StatusCodes } = require('http-status-codes');
const CustomError = require('../errors');
const cloudinary = require('cloudinary').v2;
const { BadRequestError, NotFoundError, InternalServerError } = CustomError;
const {createJWT}= require('../utils');
const twilio = require('twilio');


const ProfilePicture = async (req, res, next) => {
  const userId = req.user.userId;

  console.log('Received request to update user with ID:', userId);

  if (!userId) {
    throw new BadRequestError('User ID is missing in the request');
  }

  if (!mongoose.Types.ObjectId.isValid(userId)) {
    throw new BadRequestError('Invalid user ID format');
  }

  const user = await User.findById(userId);

  if (!user) {
    console.log(`User not found with ID: ${userId}`);
    throw new NotFoundError(`No user found with ID: ${userId}`);
  }

  if (user._id.toString() !== userId) {
    throw new CustomError.UnauthorizedError('Not authorized to update this profile');
  }

  // if (user.profilePicture) {
  //   console.log(`User with ID: ${userId} already has a profile picture.`);
  //   return next(new BadRequestError('Profile picture already set. Use updateUser to change it.'));
  // }

  if (!req.files || !req.files.media) {
    console.log('No media file uploaded, assigning a default profile picture.');

 
    user.profilePicture = user.profilePicture || user.schema.path('profilePicture').defaultValue();
    await user.save();

    return res.status(StatusCodes.OK).json({ profilePicture: user.profilePicture });
  }

  const mediaFile = req.files.media;

  try {
    const uploadPromise = new Promise((resolve, reject) => {
      const stream = cloudinary.uploader.upload_stream(
        { resource_type: 'auto', folder: 'profile_Picture' , tags: [userId,user.name]},
        (error, result) => {
          if (error) reject(error);
          else resolve(result.secure_url);
        }
      );
      stream.end(mediaFile.data);
    });

    const uploadedMediaUrl = await uploadPromise;
    user.profilePicture = uploadedMediaUrl;
    await user.save();

    return res.status(StatusCodes.OK).json({ profilePicture: uploadedMediaUrl });
  } catch (error) {
    console.error('Error uploading media:', error);
    return next(new InternalServerError('Error uploading media'));
  }
}



const deleteFromCloudinary = async (url) => {
  if (!url) return;

  const defaultUrls = User.schema.path('profilePicture').defaultValue();

  if (defaultUrls.includes(url)) {
    return;
  }

  const publicId = url.split('/').pop().split('.')[0];
  try {
    await cloudinary.uploader.destroy(`profile_Picture/${publicId}`, { resource_type: 'image' });
  } catch (error) {
    console.error('Error deleting old profile picture from Cloudinary:', error);
  }
};

const updateUser = async (req, res, next) => {
  const { name, lastName } = req.body;
  const userId = req.user.userId;

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

  user.name = name || user.name;
  user.lastName = lastName || user.lastName;

  if (req.files && req.files.media) {
    const mediaFile = req.files.media;

    try {
      const uploadPromise = new Promise((resolve, reject) => {
        const stream = cloudinary.uploader.upload_stream(
          { resource_type: 'auto', folder: 'profile_Picture', tags: [userId, user.name] },
          (error, result) => {
            if (error) reject(error);
            else resolve(result.secure_url);
          }
        );
        stream.end(mediaFile.data);
      });

      const uploadedMediaUrl = await uploadPromise;

      await deleteFromCloudinary(user.profilePicture);

      user.profilePicture = uploadedMediaUrl;
    } catch (error) {
      console.error('Error uploading media:', error);
      return next(new InternalServerError('Error uploading media'));
    }
  }

  await user.save();

  const tokenUser = {
    name: user.name,
    lastName: user.lastName,
    userId: user._id,
    role: user.role,
    profilePicture: user.profilePicture,
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
  updateUser,
  updateUserPassword,
  passwordVerify,
  ProfilePicture

};


