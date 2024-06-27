const cloudinary = require('cloudinary').v2;
const fs = require('fs');
const { StatusCodes } = require('http-status-codes');
const { BadRequestError, NotFoundError } = require('../errors');
const Job = require('../models/Job');
const mongoose = require('mongoose');
const  streamifier=require( 'streamifier')
const kyc=require('../models/Kyc')
const User = require('../models/User'); 

const addkyc= async (req,res,next)=>{ 
    const userId = req.user.userId;
  const user = await User.findById(userId);
  if (!user) {
    return next(new BadRequestError('User not found'));
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
      res.status(error instanceof NotFoundError ? StatusCodes.NOT_FOUND : StatusCodes.BAD_REQUEST).json({ error: error.message });
    }
}
}
module.exports =  addkyc ;   