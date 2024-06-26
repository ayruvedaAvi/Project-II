const cloudinary = require('cloudinary').v2;
const fs = require('fs');
const { StatusCodes } = require('http-status-codes');
const { BadRequestError, NotFoundError } = require('../errors');
const Job = require('../models/Job');
const mongoose = require('mongoose');
const  streamifier=require( 'streamifier')
const User = require('../models/User'); 

const createJob = async (req, res, next) => {
  if (!req.user || !req.user.userId) {
    return next(new BadRequestError('Please provide user'));
  }

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

    const jobData = {
      ...req.body,
      userId,
      userName: user.name,
      userLastName: user.lastName,
      userEmail: user.email,
      image: uploadedMediaUrl
    };

    const job = await Job.create(jobData);
    res.status(StatusCodes.CREATED).json({ job });
  } catch (error) {
    if (!res.headersSent) {
      res.status(error instanceof NotFoundError ? StatusCodes.NOT_FOUND : StatusCodes.BAD_REQUEST).json({ error: error.message });
    }
  }
};
const getAllPosts = async (req, res) => {//shows all the jobs posted by every user
  const jobs = await Job.find({}).limit(10).sort('-createdAt');
  const formattedJobs = jobs.map(job => ({
    id: job._id,
    Title: job.Title,
    workDescription: job.workDescription,
    status: job.status,
    userId: job.userId,
    userName: job.userName,
    userLastName: job.userLastName,
    userEmail: job.userEmail,
    jobType: job.jobType,
    jobLocation: job.jobLocation,
    price: job.price,
    image: job.image,
    createdAt: job.createdAt,
    updatedAt: job.updatedAt
  }));
  res.status(StatusCodes.OK).json({ jobs: formattedJobs, count: formattedJobs.length });
};

const getAllJobs = async (req, res) => {
  const jobId = req.body.jobId;
  const userId = req.user.id;

  try {
    let queryObject = {};

    if (jobId) {
      const job = await Job.findById(jobId);
      if (!job) {
        return res.status(404).json({ message: 'Job not found' });
      }
      queryObject.userId = job.userId;
    } else {
      queryObject.userId = userId;
    }

    const result = Job.find(queryObject);

    const jobs = await result;
    const totalJobs = await Job.countDocuments(queryObject);

    const formattedJobs = jobs.map(job => ({
      id: job._id,
      Title: job.Title,
      workDescription: job.workDescription,
      status: job.status,
      userId: job.userId,
      userName: job.userName,
      userLastName: job.userLastName,
      userEmail: job.userEmail,
      jobType: job.jobType,
      jobLocation: job.jobLocation,
      price: job.price,
      image: job.image,
      createdAt: job.createdAt,
      updatedAt: job.updatedAt
    }));

    res.status(200).json({ totalJobs, jobs: formattedJobs });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Server error' });
  }
};




const getJob = async (req, res) => {
  const { jobId } = req.body;

  console.log(`Fetching job with ID: ${jobId}`);

  const job = await Job.findById(jobId);

  if (!job) {
    console.log(`No job found with ID: ${jobId}`);
    throw new NotFoundError(`No job with id ${jobId}`);
  }
  const formattedJobs = ({
    id: job._id,
    Title: job.Title,
    workDescription: job.workDescription,
    status: job.status,
    userId: job.userId,
    userName: job.userName,
    userLastName: job.userLastName,
    userEmail: job.userEmail,
    jobType: job.jobType,
    jobLocation: job.jobLocation,
    price: job.price,
    image: job.image,
    createdAt: job.createdAt,
    updatedAt: job.updatedAt
  });
  

  res.status(StatusCodes.OK).json({ job:formattedJobs});
};

const updateJob = async (req, res, next) => {
  const {
    body: { jobId, Title, workDescription, jobType, jobLocation, price },
    files, 
    user: { userId }
  } = req;

  try {
    const job = await Job.findOne({ _id: jobId, userId });
    if (!job) {
      return next(new NotFoundError(`No job with id ${jobId} found for this user`));
    }

    if (Title !== undefined && Title !== null && Title !== '') {
      job.Title = Title;
    }
    if (workDescription !== undefined && workDescription !== null && workDescription !== '') {
      job.workDescription = workDescription;
    }
    if (jobType !== undefined && jobType !== null && jobType !== '') {
      job.jobType = jobType;
    }
    if (jobLocation !== undefined && jobLocation !== null && jobLocation !== '') {
      job.jobLocation = jobLocation;
    }
    if (price !== undefined && price !== null) {
      job.price = price;
    }

    if (!files || !files.media) {
      return next(new BadRequestError('No media file uploaded'));
    }

    const mediaFile = files.media;

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

    // Update job image with Cloudinary URL
    job.image = uploadedMediaUrl;

    // Save the updated job details
    await job.save();

    // Construct the formatted job object to send in the response
    const formattedJob = {
      id: job._id,
      Title: job.Title,
      workDescription: job.workDescription,
      status: job.status,
      userId: job.userId,
      userName: job.userName,
      userLastName: job.userLastName,
      userEmail: job.userEmail,
      jobType: job.jobType,
      jobLocation: job.jobLocation,
      price: job.price,
      image: job.image,
      createdAt: job.createdAt,
      updatedAt: job.updatedAt
    };

    // Send the formatted job object in the response
    res.status(StatusCodes.OK).json({ job: formattedJob });
  } catch (error) {
    if (!res.headersSent) {
      res.status(error instanceof NotFoundError ? StatusCodes.NOT_FOUND : StatusCodes.BAD_REQUEST).json({ error: error.message });
    }
  }
};

const deleteJob = async (req, res) => {
  const {
    user: { userId },
    body: { jobId },
  } = req;

  const job = await Job.findOne({ _id: jobId, userId: userId });
  if (!job) {
    throw new NotFoundError(`No job with id ${jobId} found for this user`);
  }

  await job.remove();

  res.status(StatusCodes.OK).send();
};

const showStats = async (req, res) => {
  let stats = await Job.aggregate([
    { $match: { user_ID: mongoose.Types.ObjectId(req.user.userId) } },
    { $group: { _id: '$status', count: { $sum: 1 } } },
  ]);

  stats = stats.reduce((acc, curr) => {
    const { _id: title, count } = curr;
    acc[title] = count;
    return acc;
  }, {});

  const defaultStats = {
    pending: stats.pending || 0,
    Taken: stats.interview || 0,
    completed: stats.completed || 0,
  };

  let monthlyApplications = await Job.aggregate([
    { $match: { user_ID: mongoose.Types.ObjectId(req.user.userId) } },
    {
      $group: {
        _id: { year: { $year: '$createdAt' }, month: { $month: '$createdAt' } },
        count: { $sum: 1 },
      },
    },
    { $sort: { '_id.year': -1, '_id.month': -1 } },
    { $limit: 6 },
  ]);

  monthlyApplications = monthlyApplications
    .map((item) => {
      const {
        _id: { year, month },
        count,
      } = item;
      const date = moment()
        .month(month - 1)
        .year(year)
        .format('MMM Y');
      return { date, count };
    })
    .reverse();

  res.status(StatusCodes.OK).json({ defaultStats, monthlyApplications });
};

// const uploadProductMedia = async (req, res) => {
//   try {
//     console.log('Incoming files:', req.files);

//     if (!req.files || !req.files.media) {
//       throw new BadRequestError('No File Uploaded');
//     }
//     const productMedia = req.files.media;
//     const files = Array.isArray(productMedia) ? productMedia : [productMedia];
//     console.log('Files to process:', files);
//     const areValidFiles = files.every(file => file.mimetype.startsWith('image') || file.mimetype.startsWith('video'));
//     if (!areValidFiles) {
//       throw new BadRequestError('Please upload image or video files only');
//     }
//     const maxImageSize = 5 * 1024 * 1024; // 5MB for images
//     const maxVideoSize = 50 * 1024 * 1024; // 50MB for videos

//     files.forEach(file => {
//       if (file.mimetype.startsWith('image') && file.size > maxImageSize) {
//         throw new BadRequestError('Please upload images smaller than 5MB');
//       }
//       if (file.mimetype.startsWith('video') && file.size > maxVideoSize) {
//         throw new BadRequestError('Please upload videos smaller than 50MB');
//       }
//     });

//     const uploadPromises = files.map(file => new Promise((resolve, reject) => {
//       const resourceType = file.mimetype.startsWith('image') ? 'image' : 'video';
//       const uploadStream = cloudinary.uploader.upload_stream({
//         use_filename: true,
//         folder: 'file-upload',
//         resource_type: resourceType,
//       }, (error, result) => {
//         if (error) {
//           reject(new InternalServerError('Cloudinary Upload Failed'));
//         } else {
//           resolve({ src: result.secure_url });
//         }
//       });

//       streamifier.createReadStream(file.data).pipe(uploadStream);
//     }));

//     const uploadedMedia = await Promise.all(uploadPromises);

//     return  uploadedMedia ;
//   } catch (error) {
//     // Handle errors
//     console.error('Upload error:', error);
//     throw error;
//   }
// };


module.exports = {
  createJob,
  deleteJob,
  getAllJobs,
  updateJob,
  getJob,
  showStats,
  // uploadProductMedia,
  getAllPosts
};