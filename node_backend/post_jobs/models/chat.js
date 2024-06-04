const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const chatSchema = new Schema({
    users: [{
        type: Schema.Types.ObjectId,
        ref: 'User', // Assuming you have a User model
        required: true
    }],
    type: {
        type: String,
        enum: ['private', 'group'],
        default: 'private'
    },
    createdAt: {
        type: Date,
        default: Date.now
    },
    updatedAt: {
        type: Date,
        default: Date.now
    }
});

// Update the `updatedAt` field on save
chatSchema.pre('save', function(next) {
    this.updatedAt = Date.now();
    next();
});

const ChatModel = mongoose.model('Chat', chatSchema);

module.exports = ChatModel;



