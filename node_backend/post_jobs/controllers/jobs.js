const cloudinary = require('cloudinary').v2;
const fs = require('fs');
const { StatusCodes } = require('http-status-codes');
const { BadRequestError, NotFoundError, UnauthenticatedError, InternalServerError } = require('../errors');
const Job = require('../models/Job');
const mongoose = require('mongoose');
const  streamifier=require( 'streamifier')
const User = require('../models/User'); 
const { sendNotificationOfJobPosted ,sendNotificationToUser } = require('./notification');

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
  const { Title, workDescription, jobType, price, latitude, longitude } = req.body;

  try {
    const uploadPromise = new Promise((resolve, reject) => {
      const stream = cloudinary.uploader.upload_stream(
        { resource_type: 'auto', folder: 'job_media', tags: [userId, user.name] },
        (error, result) => {
          if (error) reject(error);
          else resolve(result.secure_url);
        }
      );
      stream.end(mediaFile.data);
    });

    const uploadedMediaUrl = await uploadPromise;

    const jobData = {
      Title,
      workDescription,
      userId,
      userName: user.name,
      userLastName: user.lastName,
      userEmail: user.email,
      jobType,
      price,
      image: uploadedMediaUrl,
      // jobLocation: {
      //   type: 'Point',
      //   coordinates: [parseFloat(longitude), parseFloat(latitude)]
      // }
    };

    const job = await Job.create(jobData);
    const notificationTitle = 'New Job Posted';
    const notificationBody = `${user.name} ${user.lastName} posted a new job: ${Title}`;

    await sendNotificationOfJobPosted(notificationTitle, notificationBody, userId);
    res.status(StatusCodes.CREATED).json({ job });
  } catch (error) {
    if (!res.headersSent) {
      res.status(404).json({message: 'Server error' });
    }
  }
};

const applyForJob = async (req, res, next) => {
  const { jobId } = req.body;
  const workerId = req.user.userId;

  if (!workerId) {
    throw new BadRequestError('User not authenticated');
  }

  const user = await User.findById(workerId);
  if (!user || user.role !== 'Worker') {
    throw new BadRequestError('You are not authorized to apply for jobs');
  }

  const job = await Job.findById(jobId);
  if (!job) {
    throw new BadRequestError('Job not found');
  }

  // Ensure applications field is initialized
  if (!job.applications) {
    job.applications = [];
  }

  if (job.applications.some(app => app.workerId.toString() === workerId)) {
    throw new BadRequestError('You have already applied for this job');
  }

  job.applications.push({
    workerId,
    workerName: user.name
  });

  await job.save();

  const jobProvider = await User.findById(job.userId);
  if (!jobProvider) {
    throw new BadRequestError('Job provider not found');
  }

  const notificationTitle = 'Job Application';
  const notificationBody = `${user.name} has applied for your job: ${job.Title}`;

  try {
    // Send notification only to the job provider (poster)
    await sendNotificationToUser(notificationTitle, notificationBody, job.userId);
  } catch (error) {
    console.error('Error sending notification:', error);
    throw new InternalServerError('Failed to send notification');
  }

  res.status(StatusCodes.OK).json({ message: 'Application submitted successfully' });
};

const assignJob = async (req, res, next) => {
  const { jobId, workerId } = req.body;
  const job = await Job.findById(jobId);

  if (!job) {
    throw new BadRequestError('Job not found');
  }

  if (job.userId.toString() !== req.user.userId) {
    throw new UnauthenticatedError('You are not authorized to assign this job');
  }

  const applicant = job.applications.find(app => app.workerId.toString() === workerId);

  if (!applicant) {
    throw new BadRequestError('Worker not found in applications');
  }

  const worker = await User.findById(workerId);
  if (!worker || worker.role !== 'Worker') {
    throw new BadRequestError('Only users with role Worker can be assigned');
  }

  job.assignedWorker = {
    workerId: applicant.workerId,
    workerName: applicant.workerName,
  };

  job.status = 'active';

  await job.save();

  const notificationTitle = 'Job Assigned';
  const notificationBody = `You have been assigned to the job: ${job.Title}`;
  await sendNotificationToUser(notificationTitle, notificationBody, workerId);

  res.status(StatusCodes.OK).json({ message: 'Job assigned successfully' });
};




const getAllPosts = async (req, res) => {//shows all the jobs posted by every user
  const jobs = await Job.find({}).limit(10).sort('-createdAt');
  res.status(StatusCodes.OK).json({ jobs, count: jobs.length });
};

const getAllJobs = async (req, res) => {
  const jobId = req.body.jobId;
  const userId = req.user.userId;

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


    res.status(200).json({ totalJobs, jobs});
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
  res.status(StatusCodes.OK).json({job});
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

    if (Title) {
      job.Title = Title;
    }
    if (workDescription) {
      job.workDescription = workDescription;
    }
    if (jobType) {
      job.jobType = jobType;
    }
    if (jobLocation) {
      job.jobLocation = jobLocation;
    }
    if (price ) {
      job.price = price;
    }

    if (files && files.media) {
      const mediaFile = files.media;

      const uploadPromise = new Promise((resolve, reject) => {
        const stream = cloudinary.uploader.upload_stream(
          { resource_type: 'auto', folder: 'job_media' ,tags: [userId, User.name] },
          (error, result) => {
            if (error) reject(error);
            else resolve(result.secure_url);
          }
        );
        stream.end(mediaFile.data);
      });

      const uploadedMediaUrl = await uploadPromise;
      job.image = uploadedMediaUrl;
    }

    await job.save();
    res.status(StatusCodes.OK).json( job );
  } catch (error) {
    if (!res.headersSent) {
      res.status(error instanceof NotFoundError ? StatusCodes.NOT_FOUND : StatusCodes.BAD_REQUEST).json({ error: error.message });
    } else {
      next(error);
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
  getAllPosts,
  applyForJob,
  assignJob
};