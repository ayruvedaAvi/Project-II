const mongoose = require('mongoose');

const notificationSchema = new mongoose.Schema(
  {
      user_ID: {
        type: mongoose.Types.ObjectId,
        ref: 'User',
        required: [true, 'USER NOT FOUND'],
      }, 
 
    fcm_Token: {
      type: String,
      required: [true, 'Not found']
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model('Notification', notificationSchema);
