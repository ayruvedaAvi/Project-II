const jwt=require('jsonwebtoken')

const createJWT = ({payload})=>{
    const token= jwt.sign(payload,process.env.JWT_SECRET,{expiresIn:process.env.JWT_LIFETIME})
    return token
}
const isTokenValid =({token})=>jwt.verify(token, process.env.JWT_SECRET)

const tokenToResponse = ({res,user})=>{
    const token = createJWT({payload:user})

    res.status(201).json({user,token})
}
module.exports = {
    createJWT,
    isTokenValid,
    tokenToResponse
    
}