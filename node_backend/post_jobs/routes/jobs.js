const express = require('express');
const router = express.Router();
const authenticateUser = require('../middleware/authentication');
const { createJob, deleteJob, getAllJobs, updateJob, getJob, showStats, getAllPosts } = require('../controllers/jobs');
const testUser = require('../middleware/testUser');

router.route('/').post(authenticateUser, createJob).get(authenticateUser,getAllPosts)
router.route('/user').get(authenticateUser,getAllJobs)
// router.route('/uploads').post(authenticateUser,uploadProductMedia);
router.route('/stats').get(authenticateUser,showStats);


router.route('/singlejob').get(authenticateUser,getJob)
  router.route('/delete').delete(authenticateUser,testUser, deleteJob)
  router.route('/edit').patch(authenticateUser,testUser, updateJob);

module.exports = router;