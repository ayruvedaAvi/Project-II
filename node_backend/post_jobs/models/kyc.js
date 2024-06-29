const mongoose = require('mongoose');

const KYCSchema = new mongoose.Schema(
    {
        userId: {
            type: mongoose.Types.ObjectId,
            ref: 'User',
          },
          userName: {
            type: String,
            required: [true, 'Please provide user name'],
          },
          userLastName: {
            type: String,
            required: [true, 'Please provide user last name'],
          },
        nagariktaNumber: {
            type: Number,
            required: [true, 'Please provide nagarikta number'],
            maxlength: 50,
        },
        fullName:{
            type: String,
            required: [true, 'Please provide full name'],
        },  
        gender:{
            type: String,
            enum:['male','female','others'],
            required: [true, 'Please provide your gender'],
        },
        dobEnglish:{
            type: String,
            required: [true, 'Please provide your date of birth'],
        },
        dobNepali:{
            type: String,
            required: [true, 'Please provide your date of birth'],
        },
        birthPlace:{
            birthDistrict:{
                type:String,
                required:[true, 'Please provide your district'],
            },
            birthMuncipality:{
                type:String,
                required:[true, 'Please provide your muncipality'],
            },
            birthWardNumber:{
                type:String,
                required:[true, 'Please provide your ward number'],
            },
        },
        permanentAddress:{
            district:{
                type:String,
                required:[true, 'Please provide your district'],
            },
            muncipality:{
                type:String,
                required:[true, 'Please provide your muncipality'],
            },
            wardNumber:{
                type:String,
                required:[true, 'Please provide your ward number'],
            },
        },
        citizenshipIssueDate:{
            type:String,
            required:[true, 'Please provide your citizenship issue date'],
        },  
        citizenshipPhoto:{
            type:String,
            required:[true, 'Please provide your citizenship photo'],
        },
        },  { timestamps: true }); 

       
        KYCSchema.set('toJSON', {
          transform: function (doc, ret) {
            ret.id = ret._id;
            delete ret._id;
            ret.v = ret.__v;
            delete ret.__v;
          },
        });
module.exports = mongoose.model('Kyc', KYCSchema);