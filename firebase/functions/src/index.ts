import { photosRoute } from './routes/photos';
import * as express from 'express';
import * as dotenv from 'dotenv';
import * as firebase from 'firebase-functions';
import * as admin from 'firebase-admin';
import { placesRoute } from './routes/places';
import { tagsRoute } from './routes/tags';
import { TagsRepository } from './firebase/tags'
import { db } from './firebase/connection';
import { logInfo } from './logger';

declare module 'express-serve-static-core' {
    interface Request {
        language: string
        user: admin.auth.DecodedIdToken //User's ID token
    }
}

let app;

if (typeof app === 'undefined') {
    //initialize app
    app = express();
    //initialize tags repository
    const tagsRepository = new TagsRepository(db);
    // initialize dotenv
    dotenv.config();

    // accept and parse JSON content-type
    app.use(express.json());

    app.use((req, res, next) => {
        logInfo(`${req.method} request, url: ${req.url}`);
        next();
    });

    // Authorization: Bearer <Firebase ID Token>.  
    app.use(async (req, res, next) => {
        if (!req.headers.authorization || !req.headers.authorization.startsWith('Bearer ')) {
            res.status(403).send('Unauthorized - No token provided');
            return;
        }
        const idToken = req.headers.authorization.split('Bearer ')[1];
        try {
            const decodedIdToken = await admin.auth().verifyIdToken(idToken);
            req.user = decodedIdToken;
            next();
            return;
        } catch (e) {
            res.status(401).send('Unauthorized - Invalid token');
            return;
        }
    });

    // add language param to request
    app.param('language', (req, res, next, value) => {
        req.language = value;
        next();
    });

    // Find places routes
    app.use('/:language', placesRoute(tagsRepository));
    // Tags routes
    app.use('/tags', tagsRoute(tagsRepository));
    // Photo
    app.use('/photo', photosRoute());
}


export const api = firebase.region('europe-west1').https.onRequest(app);