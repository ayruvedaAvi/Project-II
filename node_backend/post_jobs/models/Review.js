const mongoose = require('mongoose');

const ReviewSchema = mongoose.Schema(
  {
    rating: {
      type: Number,
      min: 1,
      max: 5,
      required: [true, 'Please provide rating'],
    },
    comment: {
      type: String,
      required: [true, 'Please provide review text'],
    },
    reviewer: {
      type: mongoose.Schema.ObjectId,
      ref: 'User',
      required: true,
    },
  },
  { timestamps: true }
);

ReviewSchema.index({ user: 1, reviewer: 1 }, { unique: true });

ReviewSchema.statics.calculateAverageRating = async function (userId) {
  const result = await this.aggregate([
    { $match: { user: userId } },
    {
      $group: {
        _id: null,
        averageRating: { $avg: '$rating' },
        numOfReviews: { $sum: 1 },
      },
    },
  ]);

  try {
    await this.model('User').findOneAndUpdate(
      { _id: userId },
      {
        averageRating: Math.ceil(result[0]?.averageRating || 0),
        numOfReviews: result[0]?.numOfReviews || 0,
      }
    );
  } catch (error) {
    console.log(error);
  }
};

ReviewSchema.post('save', async function () {
  await this.constructor.calculateAverageRating(this.user);
});

ReviewSchema.post('remove', async function () {
  await this.constructor.calculateAverageRating(this.user);
});

module.exports = mongoose.model('Review', ReviewSchema);
