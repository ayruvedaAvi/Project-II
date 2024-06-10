const jwt = require('jsonwebtoken');

const createJWT = ({ payload }) => {
    const tokenPayload = {
        userId: payload.userId,
        phoneNumber: payload.phoneNumber, // Ensure phone number is included
        name: payload.name, // Add other necessary fields
        lastName: payload.lastName,
        role: payload.role
    };
    const token = jwt.sign(tokenPayload, process.env.JWT_SECRET, { expiresIn: process.env.JWT_LIFETIME });
    return token;
};

const isTokenValid = ({ token }) => jwt.verify(token, process.env.JWT_SECRET);

const tokenToResponse = ({ res, user }) => {
    const token = createJWT({ payload: user });
    res.status(201).json({ user, token });
};

module.exports = {
    createJWT,
    isTokenValid,
    tokenToResponse}