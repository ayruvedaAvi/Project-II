const mongoose=require('mongoose');

const FcmTokenSchema = new mongoose.Schema(
{
    userId: {
        type: mongoose.Types.ObjectId,
        ref: 'User',
    },
    registrationToken: {
        type: [String],
    },
},
{ timestamps: true }
);
module.exports = mongoose.model('FcmToken', FcmTokenSchema);