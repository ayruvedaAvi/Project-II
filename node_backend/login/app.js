require('dotenv').config();
require("express-async-errors")
const express=require('express');
const app=express()


const morgan=require('morgan')
const cookieParser = require('cookie-parser')


const dbconnect=require('./db/connect')

//routers
const authrouter=require('./routes/authRoute')

const notFoundMiddleware=require('./middleware/not-found')
const errorHandlerMiddleware=require('./middleware/error-handler')

app.use(morgan('tiny'))
app.use(express.json())
app.use(cookieParser(process.env.JWT_SECRET));

app.get('/' , (req , res)=>{
    res.send('hello from simple server')
    
});
app.get('/api/v1' , (req , res)=>{
    // console.log(req.cookies)
    console.log(req.signedCookies)
   res.send('hello from simple server')

});
app.use("/api/v1/auth/",authrouter)

app.use(notFoundMiddleware);
app.use(errorHandlerMiddleware);

const port=process.env.PORT || 5000

const start = async()=>{
    try{
        await dbconnect(process.env.MONGOO_URL)
        app.listen(port,()=>{console.log(`server connected to ${port}`)})
    }catch(error){
        console.log(error)
    }
};
start();