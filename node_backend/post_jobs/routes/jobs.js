const express = require('express');
const router = express.Router();
const sendPushNotification=require('../controllers/notification')
const {uploadProductMedia, createJob, deleteJob, getAllJobs, updateJob, getJob, showStats } = require('../controllers/jobs');
const testUser = require('../middleware/testUser');

router.route('/').post(testUser, createJob).get(getAllJobs)
router.route('/uploads').post(uploadProductMedia);
router.route('/stats').get(showStats);
router.route('/notification').post(sendPushNotification)

router
  .route('/:id')
  .get(getJob)
  .delete(testUser, deleteJob)
  .patch(testUser, updateJob);

module.exports = router;
