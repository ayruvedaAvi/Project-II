const mongoose = require('mongoose')
const validator=require('validator')

const bcrypt=require('bcryptjs')


const userSchema = new mongoose.Schema({
    name:{
        type:String,
        required:[true,'please provide name'],
        minlength:3,
        maxlength:50,
    },
    email:{
        type:String,
        unique:true,
        required:[true,'please provide email'],
        validate:{
            validator:validator.isEmail,
            message:'provide valide email'
        }
       
    },password:{
        type:String,
        required:[true,'please provide password'],
        minlength:6,
    },
    role:{
        type:String,
        enum:['admin','user'],
        default:'user',
    },
});

userSchema.pre('save',async function(){
    const salt=await bcrypt.genSalt(10);
    this.password = await bcrypt.hash(this.password,salt)
      
})


userSchema.methods.comparePassword = async function(canditatePassword){
    const isMatch=await bcrypt.compare(canditatePassword,this.password);
    return isMatch
}

module.exports=mongoose.model('User',userSchema)