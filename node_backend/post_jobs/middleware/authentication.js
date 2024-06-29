const jwt = require('jsonwebtoken');
const { UnauthenticatedError } = require('../errors');

const auth = async (req, res, next) => {
    const authHeader = req.headers.authorization;
    if (!authHeader || !authHeader.startsWith('Bearer')) {
        throw new UnauthenticatedError('Authentication invalid');
    }
    const token = authHeader.split(' ')[1];

    jwt.verify(token, process.env.JWT_SECRET, (err, payload) => {
        if (err) {
            throw new UnauthenticatedError('Authentication invalid');
        }
        req.user = { userId: payload.userId, phoneNumber: payload.phoneNumber };
        // console.log("Middleware - User ID:", req.user.userId, "Phone Number:", req.user.phoneNumber); // Log user details
        next();
    });
};

module.exports = auth;
