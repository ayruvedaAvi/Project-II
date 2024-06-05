const cloudinary = require('cloudinary').v2;
const fs = require('fs');
const { StatusCodes } = require('http-status-codes');
const { BadRequestError, NotFoundError } = require('../errors');
const Job = require('../models/Job');
const mongoose = require('mongoose');
const  streamifier=require( 'streamifier')

const createJob = async (req, res) => {//job create garcha 
  if (!req.user || !req.user.userId) {
    throw new BadRequestError('Please provide user');
  }

  req.body.userId = req.user.userId;

  const job = await Job.create(req.body);
  res.status(StatusCodes.CREATED).json({ job });
};
const getAllPosts = async (req, res) => {//shows all the jobs posted by every user
  const job = await Job.find({}).limit(10).sort('-createdAt');

  res.status(StatusCodes.OK).json({ job, count: job.length });
};

const getAllJobs = async (req, res) => {
  const { search, status, jobType, sort } = req.query;

  const queryObject = {
    userId: req.user.userId,
  };

  if (search) {
    queryObject.workDescription = { $regex: search, $options: 'i' };
  }
  if (status && status !== 'all') {
    queryObject.status = status;
  }
  if (jobType && jobType !== 'all') {
    queryObject.jobType = jobType;
  }
  let result = Job.find(queryObject);

  if (sort === 'latest') {
    result = result.sort('-createdAt');
  }
  if (sort === 'oldest') {
    result = result.sort('createdAt');
  }
  if (sort === 'a-z') {
    result = result.sort('workDescription');
  }
  if (sort === 'z-a') {
    result = result.sort('-workDescription');
  }
  const jobs = await result;
  const totalJobs = await Job.countDocuments(queryObject);
  res.status(StatusCodes.OK).json({ jobs, totalJobs});
};

const getJob = async (req, res) => {
  const { id: jobId } = req.params;
  console.log(`Fetching job with ID: ${jobId}`);
  const job = await Job.findById(jobId);
  if (!job) {
    console.log(`No job found with ID: ${jobId}`);
    throw new NotFoundError(`No job with id ${jobId}`);
  }
  res.status(StatusCodes.OK).json({ job });
};

const updateJob = async (req, res) => {
  const {
    body: { Title, workDescription },
    user: { userId },
    params: { id: jobId },
  } = req;
  if (!Title || !workDescription) {
    throw new BadRequestError('Title or workDescription fields cannot be empty');
  }
  const job = await Job.findOne({ _id: jobId, userId: userId });
  if (!job) {
    throw new NotFoundError(`No job with id ${jobId} found for this user`);
  }
  job.Title = Title;
  job.workDescription = workDescription;
  await job.save();
  res.status(StatusCodes.OK).json({ job });
};

const deleteJob = async (req, res) => {
  const {
    user: { userId },
    params: { id: jobId },
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

const uploadProductMedia = async (req, res) => {
  try {
    console.log('Incoming files:', req.files);

    if (!req.files || !req.files.media) {
      throw new BadRequestError('No File Uploaded');
    }
    const productMedia = req.files.media;
    const files = Array.isArray(productMedia) ? productMedia : [productMedia];
    console.log('Files to process:', files);
    const areValidFiles = files.every(file => file.mimetype.startsWith('image') || file.mimetype.startsWith('video'));
    if (!areValidFiles) {
      throw new BadRequestError('Please upload image or video files only');
    }
    const maxImageSize = 5 * 1024 * 1024; // 5MB for images
    const maxVideoSize = 50 * 1024 * 1024; // 50MB for videos

    files.forEach(file => {
      if (file.mimetype.startsWith('image') && file.size > maxImageSize) {
        throw new BadRequestError('Please upload images smaller than 5MB');
      }
      if (file.mimetype.startsWith('video') && file.size > maxVideoSize) {
        throw new BadRequestError('Please upload videos smaller than 50MB');
      }
    });

    const uploadPromises = files.map(file => new Promise((resolve, reject) => {
      const resourceType = file.mimetype.startsWith('image') ? 'image' : 'video';
      const uploadStream = cloudinary.uploader.upload_stream({
        use_filename: true,
        folder: 'file-upload',
        resource_type: resourceType,
      }, (error, result) => {
        if (error) {
          reject(new InternalServerError('Cloudinary Upload Failed'));
        } else {
          resolve({ src: result.secure_url });
        }
      });

      streamifier.createReadStream(file.data).pipe(uploadStream);
    }));

    const uploadedMedia = await Promise.all(uploadPromises);

    return res.status(StatusCodes.OK).json({ media: uploadedMedia });
  } catch (error) {
    // Handle errors
    console.error('Upload error:', error);
    throw error;
  }
};




module.exports = {
  createJob,
  deleteJob,
  getAllJobs,
  updateJob,
  getJob,
  showStats,
  uploadProductMedia,
  getAllPosts
};