require('dotenv').config()

const accountsid=process.env.Account_SID
const authToken = process.env.Auth_Token

const client=require("twilio")(accountsid,authToken)

const sendSMS=async(body)=>{
    let msgOption={
        from: process.env,
        to:process.env,
        body,
    };
    try{
        const message = await client.messages.create(msgOption);
        console.log(message)
    }catch(err){
        console.log(err)
    }
}
