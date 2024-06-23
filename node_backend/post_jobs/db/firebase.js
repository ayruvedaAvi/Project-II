const admin = require('firebase-admin');
const serviceAccount = require('./path/to/serviceAccountKey.json');
const messaging = admin.messaging();

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});