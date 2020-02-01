import * as admin from 'firebase-admin';

admin.initializeApp();

export const db: FirebaseFirestore.Firestore = admin.firestore();