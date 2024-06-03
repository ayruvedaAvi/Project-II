// const fs = require("fs");
// const path = require('path');
// var FCM = require('fcm-node');

// const sendPushNotification = async(user_ID,message) => {

//     try {
  
//       console.log('User Id:- '+user_ID);
//       console.log('message:- '+message);
  
//       fs.readFile(path.join(__dirname,'../FireBaseConfig.json'), "utf8", async(err, jsonString) => {
//       if (err) {
//           console.log("Error reading file from disk:", err);
//           return err;
//         }
//         try {
  
//           //firebase push notification send
//           const data = JSON.parse(jsonString);
//           var serverKey = data.SERVER_KEY;
//           var fcm = new FCM(serverKey);
  
//           var push_tokens = await pushMessage.findOne({ 
//             where:{
//               user_ID:user_ID
//             }
//           });
          
//           var reg_ids = [];
//           push_tokens.forEach(token => {
//             reg_ids.push(token.fcm_token)
//           })
  
//           if(reg_ids.length > 0){
  
//             var pushMessage = { //this may vary according to the message type (single recipient, multicast, topic, et cetera)
//               registration_ids:reg_ids,
//               content_available: true,
//               mutable_content: true,
//               notification: {
//                   body: message,
//                   icon : 'myicon',//Default Icon
//                   sound : 'mySound',//Default sound
//                   // badge: badgeCount, example:1 or 2 or 3 or etc....
//               },
//               // data: {
//               //   notification_type: 5,
//               //   conversation_id:inputs.user_ID,
//               // }
//             };
          
//             fcm.send(pushMessage, function(err, response){
//                 if (err) {
//                     console.log("Something has gone wrong!",err);
//                 } else {
//                     console.log("Push notification sent.", response);
//                 }
//             });
  
//           }
  
  
//         } catch (err) {
//           console.log("Error parsing JSON string:", err);
//         }
//       });
  
//     } catch (error) {
//       console.log(error);
//     }
  
//   }
//   module.exports=sendPushNotification