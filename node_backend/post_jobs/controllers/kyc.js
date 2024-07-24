const cloudinary = require('cloudinary').v2;
const fs = require('fs');
const { StatusCodes } = require('http-status-codes');
const { BadRequestError, NotFoundError } = require('../errors');
const Job = require('../models/Job');
const mongoose = require('mongoose');
const  streamifier=require( 'streamifier')
const kyc=require('../models/kyc');
const User = require('../models/User'); 

const addkyc = async (req, res, next) => {
  const userId = req.user.userId;
  const user = await User.findById(userId);

  if (!user) {
    return next(new BadRequestError('User not found'));
  }

  const existingKyc = await kyc.findOne({ userId });
  if (existingKyc) {
    return next(new BadRequestError('KYC already submitted'));
  }

  if (!req.files || !req.files.media) {
    return next(new BadRequestError('No media file uploaded'));
  }

  const mediaFile = req.files.media;

  try {
    const uploadPromise = new Promise((resolve, reject) => {
      const stream = cloudinary.uploader.upload_stream(
        { resource_type: 'auto', folder: 'job_media' },
        (error, result) => {
          if (error) reject(error);
          else resolve(result.secure_url);
        }
      );
      stream.end(mediaFile.data);
    });

    const uploadedMediaUrl = await uploadPromise;
    const kycData = {
      ...req.body,
      citizenshipPhoto: uploadedMediaUrl,
      userId,
      userName: user.name,
      userLastName: user.lastName,
      userEmail: user.email,
    };

    const kycDoc = await kyc.create(kycData);

    res.status(StatusCodes.CREATED).json({ kyc: kycDoc });
  } catch (error) {
    if (!res.headersSent) {
      res.status(StatusCodes.BAD_REQUEST).json({ error: error.message });
    }
  }
};

const deleteKyc = async (req, res, next) => {
  const userId = req.user.userId;

  try {
    const kycDoc = await kyc.findOneAndDelete({ userId });

    if (!kycDoc) {
      return next(new BadRequestError('KYC not found'));
    }

    res.status(StatusCodes.OK).json({ message: 'KYC deleted successfully from database' });
  } catch (error) {
    if (!res.headersSent) {
      res.status(StatusCodes.INTERNAL_SERVER_ERROR).json({ error: error.message });
    }
  }
};

module.exports =  {addkyc,deleteKyc} ;   