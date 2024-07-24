const express = require('express');
const router = express.Router();
const authenticateUser = require('../middleware/authentication');
const  {addkyc,deleteKyc}  = require('../controllers/kyc');

router.route('/').post(authenticateUser, addkyc);
router.route('/').delete(authenticateUser, deleteKyc);

 module.exports = router;