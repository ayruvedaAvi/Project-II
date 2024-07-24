const express = require('express');
const router = express.Router();
const {auth, checkBlacklist} = require('../middleware/authentication');
const { createJob, deleteJob, getAllJobs, updateJob, getJob, showStats, getAllPosts,  applyForJob ,assignJob } = require('../controllers/jobs');
const testUser = require('../middleware/testUser');
const searchJobs=require('../controllers/filterJobs')

router.route('/search').get(searchJobs)
router.route('/').post(auth, checkBlacklist, createJob).get(auth,getAllPosts)
router.route('/user').get(auth,checkBlacklist,getAllJobs)
// router.route('/uploads').post(authenticateUser,uploadProductMedia);
router.route('/stats').get(auth,checkBlacklist,showStats);


router.route('/singlejob').get(auth,checkBlacklist,getJob)
  router.route('/delete').delete(auth,checkBlacklist, deleteJob)
  router.route('/edit').patch(auth,checkBlacklist, updateJob);
  router.route('/applyjob').patch(auth, checkBlacklist, applyForJob );
  router.route('/assign').patch( auth,checkBlacklist,assignJob);

module.exports = router;