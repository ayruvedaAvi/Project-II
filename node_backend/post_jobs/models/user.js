const mongoose = require('mongoose')
const validator=require('validator')

const bcrypt=require('bcryptjs');



const userSchema = new mongoose.Schema({
  profilePicture: {
    type: String,
    default: function() {
      const urls = [
        "https://res.cloudinary.com/debjnxbys/image/upload/v1719296060/profile_Picture/lmwikhknerjjeac1gu3b.avif",
        "https://res.cloudinary.com/debjnxbys/image/upload/v1719296273/profile_Picture/xfehfyieow7ichyucqve.jpg",
        "https://res.cloudinary.com/debjnxbys/image/upload/v1719296270/profile_Picture/r2sxxekwmg2dld5czj32.jpg",
        "https://res.cloudinary.com/debjnxbys/image/upload/v1719296252/profile_Picture/auopkluaqi3tzrnl6fyd.avif",
        "https://res.cloudinary.com/debjnxbys/image/upload/v1719296243/profile_Picture/w2a5evfkprpif82verhs.avif",
        "https://res.cloudinary.com/debjnxbys/image/upload/v1719296216/profile_Picture/zqelbqsjagswlsgiopck.jpg"
      ];
      return urls[Math.floor(Math.random() * urls.length)];
    }
  },
    name:{
        type:String,
        required:[true,'please provide name'],
        minlength:3,
        maxlength:50,
    },
    lastName: {
        type: String,
        required:[true,"lastname required"],
        minlength:3,
        maxlength: 20,
      },
      email: {
        type: String,
        required:[true,'please provide email'],
        validate: {
            validator: function(value) {
                if (value) {
                    return validator.isEmail(value);
                }
                return true; 
            },
            message: 'Please provide a valid email'
        }
    },
    password:{
        type:String,
        required:[true,'please provide password'],
    },
    phoneNumber: {
        type: String,
        required: [true, 'Please provide phone number'],
      },
    role:{
        type:String,
        enum:['WorkProvider','Worker'],
        default:'WorkProvide'
    },
    isActive: {
        type: Boolean,
        default: false,
    },
    fcmToken:[{
      type:String}]
    
});

userSchema.pre('save', async function () {
    if (!this.isModified('password')) return;
    const salt = await bcrypt.genSalt(10);
    this.password = await bcrypt.hash(this.password, salt);
  });
  
  userSchema.methods.comparePassword = async function (canditatePassword) {
    const isMatch = await bcrypt.compare(canditatePassword, this.password);
    return isMatch;
  };

const User = mongoose.models.User || mongoose.model('User', userSchema);

module.exports = User;