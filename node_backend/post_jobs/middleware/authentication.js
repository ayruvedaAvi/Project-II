const User = require('../models/User');
const jwt = require('jsonwebtoken');
const { UnauthenticatedError } = require('../errors');

const tokenBlacklist = new Set();

const checkBlacklist = (req, res, next) => {
  const authHeader = req.headers.authorization;
  if (authHeader) {
    const token = authHeader.split(' ')[1];
    if (tokenBlacklist.has(token)) {
      return next(new UnauthenticatedError('Token is blacklisted'));
    }
  }
  next();
};

const auth = async (req, res, next) => {
  const authHeader = req.headers.authorization;
  if (!authHeader || !authHeader.startsWith('Bearer')) {
    throw new UnauthenticatedError('Authentication invalid');
  }
  const token = authHeader.split(' ')[1];

  // Check if the token is blacklisted
  if (tokenBlacklist.has(token)) {
    throw new UnauthenticatedError('Token is blacklisted');
  }

  jwt.verify(token, process.env.JWT_SECRET, (err, payload) => {
    if (err) {
      throw new UnauthenticatedError('Authentication invalid');
    }
    req.user = { userId: payload.userId, phoneNumber: payload.phoneNumber };
    next();
  });
};

module.exports = {
  auth,
  checkBlacklist,
  tokenBlacklist,
};
