const mongoose = require('mongoose');

const JobSchema = new mongoose.Schema(
  {
    Title: {
      type: String,
      required: [true, 'Please provide Title name'],
      maxlength: 50,
    },
    workDescription: {
      type: String,
      required: [true, 'Please provide workDescription'],
      maxlength: 100,
    },
    status: {
      type: String,
      enum: ['pending', 'Taken','completed'],
      default: 'pending',
    },
    userId: {
      type: mongoose.Types.ObjectId,
      ref: 'User',
      required: [true, 'Please provide user'],
    }, 
    jobType: {
      type: String,
      enum: ['Electrical', 'shift home', 'Delivery', 'Plumbing','others'],
      default: 'others',
    },
    jobLocation: {
      type: String,
      default: 'my city',
      required: true,
    },
    price: {
      type: Number,
      required: true,
    },
    image: {
      type: String,
      required: true,
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model('Job', JobSchema);