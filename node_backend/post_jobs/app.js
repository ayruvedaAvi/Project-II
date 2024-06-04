require('dotenv').config();
require('express-async-errors');
const express = require('express');
const fileUpload = require('express-fileupload');
const cloudinary = require('cloudinary').v2;
const path = require('path');
const helmet = require('helmet');
const xss = require('xss-clean');
const morgan = require('morgan');
const bodyParser = require('body-parser');
const connectDB = require('./db/connect');
const authenticateUser = require('./middleware/authentication');
const notFoundMiddleware = require('./middleware/not-found');
const errorHandlerMiddleware = require('./middleware/error-handler');
const http = require('http')
const { Server } = require("socket.io");
const chatSocket = require('./socekts/chatSocket');

const app = express();
const server = http.createServer(app)

// Cloudinary configuration
cloudinary.config({
  cloud_name: process.env.CLOUD_NAME,
  api_key: process.env.CLOUD_API_KEY,
  api_secret: process.env.CLOUD_API_SECRET,
});

const io = new Server(server, {
  cors: {
    origin: "*"
  }
})
chatSocket(io)

app.set('trust proxy', 1);

app.use(express.static(path.resolve(__dirname, './client/build')));
app.use(morgan('tiny'));
app.use(express.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(helmet());
app.use(xss());
app.use(fileUpload({ useTempFiles: true }));

// Routers
const authRouter = require('./routes/auth');
const jobsRouter = require('./routes/jobs');
const chatRoutes=require('./routes/chat');
const messageRoutes=require('./routes/message')


// Use routes
app.use('/api/v1/auth', authRouter);
app.use('/api/v1/jobs', authenticateUser, jobsRouter);
app.use('/api/v1/chat',authenticateUser,chatRoutes)
app.use('/api/v1/message',authenticateUser,messageRoutes)

// Error handling middleware
app.use(notFoundMiddleware);
app.use(errorHandlerMiddleware);

const port = process.env.PORT || 5000;

const start = async () => {
  try {
    await connectDB(process.env.MONGOO_URL);
    app.listen(port, () =>
      console.log(`Server is listening on port ${port}...`)
    );
  } catch (error) {
    console.log(error);
  }
};

start();
