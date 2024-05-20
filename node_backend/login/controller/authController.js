const User= require('../models/user')
const { StatusCodes }=require('http-status-codes')
const CustomError=require('../errors')
const jwt=require('jsonwebtoken')
 const {attachCookiesToResponse}=require('../utils')



const register= async(req,res) =>{
    const {email,name,password}=req.body;
    
    const emailAlreadyExist=await User.findOne({email})
    if(emailAlreadyExist){
        throw new CustomError.BadRequestError('email already registered')
    }
    const isMyfirstacc=(await User.countDocuments({}))===0
     const role = isMyfirstacc ? 'admin' : 'user';

    const user=await User.create({name,email,password,role})

const tokenUser={name:user.name,iserId:user._id,role:user.role}
  attachCookiesToResponse({res,user:tokenUser})
  res.status(StatusCodes.CREATED).json({user:tokenUser})

    
  
};


const login= async(req,res) =>{
    const {email,password}=req.body;

    if(!email || !password){
        throw new CustomError.BadRequestError("Invalid email and password")
    }
    const user = await User.findOne({email});
    if(!user){
        throw new CustomError.UnauthenticatedError("Invalid user")
    }
    const isPasswordCorrect=await user.comparePassword(password)
    if(!isPasswordCorrect){
        throw new CustomError.UnauthenticatedError("Password Incorrect")
    }
    const tokenUser={name:user.name,iserId:user._id,role:user.role}
  attachCookiesToResponse({res,user:tokenUser})
  res.status(StatusCodes.CREATED).json({user:tokenUser})

};






const logout= async(req,res) =>{
    res.cookie('token','logout',{httpOnly:true,expire:new Date(Date.now())})
    // res.status(StatusCodes.OK).json({msg:"log out"})
    
};

module.exports={
    register,
    login,
    logout,
}