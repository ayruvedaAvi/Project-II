const ChatModel = require('../models/chat');

const createPrivateChat = async (req, res) => {
    const { userId } = req.body;
    const loggedInUserId = req.user ? req.user.userId : null;
  
    // Log the values for debugging
    console.log("Logged in user ID:", loggedInUserId);
    console.log("Target user ID:", userId);
  
    if (!loggedInUserId || !userId) {
      return res.status(400).json({ status: false, error: "Both user IDs are required" });
    }
  
    let userIds = [loggedInUserId, userId];
  
    try {
      // Check if a private chat between the users already exists
      const chat = await ChatModel.findOne({
        users: { $all: userIds },
        type: 'private'
      });
  
      if (chat) {
        return res.send({
          data: chat,
          status: true
        });
      }
  
      // Create a new private chat
      const newChat = await ChatModel.create({
        users: userIds,
        type: 'private'
      });
  
      res.send({
        data: newChat,
        status: true
      });
    } catch (error) {
      res.status(403).json({ status: false, error: error.message });
    }
  };

const createGroupChat = async (req, res) => {
    const { userIds = [], chatName } = req.body; // Default to an empty array if userIds is undefined
    let allUsers = [...userIds]; // Create a copy of userIds
    allUsers.push(req.user.user_id); // Add the requesting user's ID

    try {
        const chat = await ChatModel.findOne({
            users: { $all: allUsers },
            type: "group"
        });
        
        if (chat) {
            res.send({
                data: chat,
                status: true,
            });
            return;
        }

        const newChat = await ChatModel.create({
            users: allUsers, // Use allUsers here to include the requesting user
            chatName: chatName,
            type: "group",
            groupAdmin: req.user.user_id
        });

        res.send({
            data: newChat,
            status: true,
        });
    } catch (error) {
        res.status(403).json({ status: false, error: error.message });
    }
};

const myChats = async (req, res) => {
    try {
        const chats = await ChatModel.find({
            users: req.user.user_id
        }).populate({
            path: "users",
            select: "userName email online lastSeen"
        }).sort({ updatedAt: -1 })
        res.send({
            data: chats,
            status: true,
        })
    } catch (error) {
        res.status(403).json({ status: false, error: error })
    }
}

const chatById = async (req, res) => {
    const chatId = req.query.chatId
    console.log("chatIdchatId",chatId)
    try {
        const chats = await ChatModel.findById(chatId).populate({
            path: "users",
            select: "userName email online lastSeen"
        })
        res.send({
            data: chats,
            status: true,
        })
    } catch (error) {
        res.status(403).json({ status: false, error: error })
    }
}

module.exports = {
    createPrivateChat,
    createGroupChat,
    myChats,
    chatById
}