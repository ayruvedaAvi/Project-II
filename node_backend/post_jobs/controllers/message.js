const MessageModel = require('../models/message');
const ChatModel = require('../models/chat');
const sendNotification = require('./notification'); 

const sendMessage = async (req, res) => {
    const { chatId, text, receiverId, type } = req.body;
    try {
        // Create a new message
        const newMessage = await MessageModel.create({
            text,
            chatId,
            user: req.user.userId
        });

        // Update the chat with the latest message
        const chatUpdate = await ChatModel.findByIdAndUpdate(chatId, {
            latestMessage: text
        }, {
            new: true
        }).populate({
            path: 'users',
            select: 'name email'
        });

        // Send a notification to the receiver
        await sendNotification({
            userId: receiverId,
            chatId: chatId,
            text: text,
            roomData: chatUpdate
        });

        res.send({
            data: newMessage,
            roomData: chatUpdate,
            status: true,
        });
    } catch (error) {
        res.status(403).json({ status: false, error: error.message });
    }
};

const myMessages = async (req, res) => {
    const { chatId, userId } = req.query;
    const page = parseInt(req.query.page) || 1;
    const limit = parseInt(req.query.limit) || 10;
    const skip = (page - 1) * limit;
    try {
        const messages = await MessageModel.find({
            chatId: chatId,
            user: userId  // Filter messages by user ID
        }).populate({
            path: 'user',
            select: 'name email'
        }).sort({ createdAt: -1 }).skip(skip).limit(limit);
        res.send({
            data: messages,
            status: true,
        });
    } catch (error) {
        res.status(403).json({ status: false, error: error.message });
    }
};

module.exports = {
    sendMessage,
    myMessages
};
