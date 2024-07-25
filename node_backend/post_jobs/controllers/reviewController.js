const Review = require('../models/Review');
const User = require('../models/User');
const { StatusCodes } = require('http-status-codes');
const CustomError = require('../errors');

const createReview = async (req, res, next) => {
  const { userId } = req.body;

  if (!userId) {
    return res.status(400).send({ message: 'User ID is required' });
  }

  const reviewerId = req.user.userId;

  const reviewer = await User.findOne({ _id: reviewerId });
  if (!reviewer || reviewer.role !== 'work provider') {
    return res.status(403).send({ message: 'Only work providers can give reviews' });
  }

  if (userId === reviewerId) {
    return res.status(400).send({ message: 'You cannot review yourself' });
  }

  const isValidUser = await User.findOne({ _id: userId });
  if (!isValidUser) {
    return next(new CustomError.NotFoundError(`No user with id: ${userId}`));
  }

  const alreadySubmitted = await Review.findOne({
    user: userId,
    reviewer: reviewerId,
  });

  if (alreadySubmitted) {
    return next(new CustomError.BadRequestError('You have already submitted a review for this user'));
  }

  req.body.reviewer = reviewerId;
  const review = await Review.create(req.body);
  res.status(StatusCodes.CREATED).json({ review });
};

const getAllReviewsForUser = async (req, res, next) => {
  const { id: userId } = req.body; 

  if (!userId) {
    return res.status(400).send({ message: 'User ID is required' });
  }

  const user = await User.findOne({ _id: userId });
  if (!user) {
    return next(new CustomError.NotFoundError(`No user with id: ${userId}`));
  }

  const reviews = await Review.find({ user: userId }).populate({
    path: 'reviewer',
    select: 'name email',
  });

  res.status(StatusCodes.OK).json({ reviews, count: reviews.length });
};

const getSingleReview = async (req, res) => {
  const { id: reviewId } = req.params;

  const review = await Review.findOne({ _id: reviewId });

  if (!review) {
    throw new CustomError.NotFoundError(`No review with id ${reviewId}`);
  }

  res.status(StatusCodes.OK).json({ review });
};

const updateReview = async (req, res) => {
  const { id: reviewId } = req.body;
  const { rating, title, comment } = req.body;

  const review = await Review.findOne({ _id: reviewId });

  if (!review) {
    throw new CustomError.NotFoundError(`No review with id ${reviewId}`);
  }

  checkPermissions(req.user, review.reviewer);

  review.rating = rating;
  review.title = title;
  review.comment = comment;

  await review.save();
  res.status(StatusCodes.OK).json({ review });
};

const deleteReview = async (req, res) => {
  const { id: reviewId } = req.body;

  const review = await Review.findOne({ _id: reviewId });

  if (!review) {
    throw new CustomError.NotFoundError(`No review with id ${reviewId}`);
  }

  checkPermissions(req.user, review.reviewer);
  await review.remove();
  res.status(StatusCodes.OK).json({ msg: 'Success! Review removed' });
};

const getSingleUserReviews = async (req, res) => {
  const { id: userId } = req.body;
  const reviews = await Review.find({ user: userId });
  res.status(StatusCodes.OK).json({ reviews, count: reviews.length });
};

module.exports = {
  createReview,
  getAllReviewsForUser,
  getSingleReview,
  updateReview,
  deleteReview,
  getSingleUserReviews,
};
