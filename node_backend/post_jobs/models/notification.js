const mongoose = require('mongoose');

const notificationSchema = new mongoose.Schema({
  userId: { 
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true
  },
  title: {
    type: String, 
    required: true
  },
  body: {
    type: String,
    required: true
  },
  read: { 
    type: Boolean, 
    default: false 
  },
  createdAt: { 
    type: Date, 
    default: Date.now 
  }
});
notificationSchema.set('toJSON', {
  transform: function (doc, ret) {
    ret.id = ret._id;
    delete ret._id;
    ret.v = ret.__v;
    delete ret.__v;
  },
});
module.exports = mongoose.model('Notification', notificationSchema);
