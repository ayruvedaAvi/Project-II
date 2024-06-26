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
    userName: {
      type: String,
      required: [true, 'Please provide user name'],
    },
    userLastName: {
      type: String,
      required: [true, 'Please provide user last name'],
    },
    userEmail: {
      type: String,
      required: [true, 'Please provide user email'],
    },
    jobType: {
      type: String,
      enum: ['Technical','Household','Repair','Construction','Cleaning','Gardening','Cooking','Shifting Service','Others'],
      required:[true,'Select the job categories ']
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
      require:true
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model('Job', JobSchema);