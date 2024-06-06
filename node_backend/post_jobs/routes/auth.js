const express = require('express');
const router = express.Router();

const rateLimiter = require('express-rate-limit');

const apiLimiter = rateLimiter({
  windowMs: 15 * 60 * 1000,
  max: 10,
  message: {
    msg: 'Too many requests from this IP, please try again after 15 minutes',
  },
});

const { register, login,logout,verify } = require('../controllers/auth');
router.post('/register', apiLimiter, register);
router.post('/verify',apiLimiter,verify)
router.post('/login', apiLimiter, login);
router.get('/logout',logout)

module.exports = router;
