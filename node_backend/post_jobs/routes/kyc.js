const express = require('express');
const router = express.Router();
const {checkBlacklist,auth} = require('../middleware/authentication');
const  {addkyc,deleteKyc}  = require('../controllers/kyc');

router.route('/').post(auth,checkBlacklist, addkyc);
router.route('/').delete(auth,checkBlacklist, deleteKyc);

 module.exports = router;