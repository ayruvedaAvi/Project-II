const express = require('express');
const router = express.Router();
const authenticateUser = require('../middleware/authentication');
const {uploadProductMedia, createJob, deleteJob, getAllJobs, updateJob, getJob, showStats, getAllPosts } = require('../controllers/jobs');
const testUser = require('../middleware/testUser');

router.route('/').post(authenticateUser, createJob).get(authenticateUser,getAllPosts)
router.route('/user').get(authenticateUser,getAllJobs)
router.route('/uploads').post(authenticateUser,uploadProductMedia);
router.route('/stats').get(authenticateUser,showStats);


router
  .route('/:id')
  .get(authenticateUser,getJob)
  .delete(authenticateUser,testUser, deleteJob)
  .patch(authenticateUser,testUser, updateJob);

module.exports = router;