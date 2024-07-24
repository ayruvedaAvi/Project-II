require('dotenv').config();
require('express-async-errors');
const express = require('express');
const session = require('express-session');
const fileUpload = require('express-fileupload');
const cloudinary = require('cloudinary').v2;
const path = require('path');
const helmet = require('helmet');
const xss = require('xss-clean');
const morgan = require('morgan');
const bodyParser = require('body-parser');

const connectDB = require('./db/connect');
const {auth} = require('./middleware/authentication');
const notFoundMiddleware = require('./middleware/not-found');
const errorHandlerMiddleware = require('./middleware/error-handler');

const app = express();

// Cloudinary configuration
cloudinary.config({
  cloud_name: process.env.CLOUD_NAME,
  api_key: process.env.CLOUD_API_KEY,
  api_secret: process.env.CLOUD_API_SECRET,
});

app.set('trust proxy', 1);

app.use(express.static(path.resolve(__dirname, './client/build')));
app.use(morgan('tiny'));
app.use(express.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(helmet());
app.use(xss());
app.use(fileUpload({ useTempFiles: false }));


// Routers
const authRouter = require('./routes/auth');
const jobsRouter = require('./routes/jobs');
const userRouter = require('./routes/userRoutes');
const forgetPassword=require('./routes/forgetPassword')
const notification = require('./routes/notification');
const kycRouter = require('./routes/kyc');

app.get('/', (req, res) => {
  res.send('Welcome to the LaborlanceAPI');
});

// Use routes
app.use('/api/v1/auth', authRouter);
app.use('/api/v1/jobs', auth, jobsRouter);
app.use('/api/v1/users', auth,userRouter);
app.use('/api/v1/forgetPassword',forgetPassword)
app.use('/api/v1/notification', notification);
app.use('/api/v1/kyc',auth,kycRouter);

// Error handling middleware
app.use(notFoundMiddleware);
app.use(errorHandlerMiddleware);

const port = process.env.PORT || 5000;

const start = async () => {
  try {
    await connectDB(process.env.MONGOO_URL); // Correct the environment variable name
    app.listen(port, () =>
      console.log(`Server is listening on port ${port}...`)
    );
  } catch (error) {
    console.log(error);
  }
};

start();
