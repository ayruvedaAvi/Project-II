const admin = require('firebase-admin');

const sendNotification = async (notificationData) => {
  console.log("notification data received", notificationData);
  const staticFcmToken  = "";

  try {
    // let findUser = await UserModel.findById(notificationData?.userId);
    let findUser = {
        fcmToken: staticFcmToken 
      }
    console.log("findUser", findUser);
  
    if (!!findUser?.fcmToken) {
      let notificationPayload = {
        roomId: notificationData?.chatId,
        roomName: findUser.userName,
        receiverIds: notificationData?.userId,
        type: notificationData.roomData.type
      };

      // Construct the message payload
      const message = {
        token: findUser?.fcmToken,
        data: {
          title: "New Message", 
          body: notificationData.text, 
          notification_type: "chat",
          navigationId: 'messages',
          data: JSON.stringify(notificationPayload) 
        }
      };

      // Send the message using the Firebase Admin SDK
      const response = await admin.messaging().send(message);
      console.log("Notification sent successfully:", response);
    }
  } catch (error) {
    console.error("Notification failed:", error);
  }
};
module.exports=sendNotification