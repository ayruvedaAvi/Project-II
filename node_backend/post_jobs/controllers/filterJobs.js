const cloudinary = require('cloudinary').v2;
const fs = require('fs');
const { StatusCodes } = require('http-status-codes');
const { BadRequestError, NotFoundError } = require('../errors');
const Job = require('../models/Job');
const mongoose = require('mongoose');
const streamifier = require('streamifier');
const User = require('../models/User'); 

const searchJobs = async (req, res) => {
    const { jobType, sort } = req.body;
  
    const queryObject = 
   {} ;
  
    // Add jobType to queryObject if it's provided and is one of the valid values
    const validJobTypes = ['Technical', 'Household', 'Repair', 'Construction', 'Cleaning', 'Gardening', 'Cooking', 'Shifting Service', 'Others'];
    if (jobType && validJobTypes.includes(jobType)) {
      queryObject.jobType = jobType;
    }
    let result = Job.find(queryObject);
if(!sort){
    result=result.sort('-createdAt')
}
    if (sort === 'latest') {
      result = result.sort('-createdAt');
    } else if (sort === 'oldest') {
      result = result.sort('createdAt');
    } 

    const jobs = await result;
    const totalJobs = await Job.countDocuments(queryObject);
    console.log('Jobs Found:', jobs);
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
  
    res.status(StatusCodes.OK).json({ jobs: formattedJobs, totalJobs });
};

module.exports = searchJobs