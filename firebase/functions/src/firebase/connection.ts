import * as admin from 'firebase-admin';

const serviceAccount = require('../service-account-credentials.json');
admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

export const db: FirebaseFirestore.Firestore = admin.firestore();