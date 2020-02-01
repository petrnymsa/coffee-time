
declare module 'express-serve-static-core' {
    interface Request {
        language: string
    }
}

import * as express from 'express';
import * as dotenv from 'dotenv';
import { ValidationError, getPhoto } from './google';
import { places } from './routes/places';
import { tags } from './routes/tags';
import { TagsRepository } from './firebase/tags'
import { db } from './firebase/connection';


//initialize app
const app = express();
//initialize tags repository
const tagsRepository = new TagsRepository(db);
// initialize dotenv
dotenv.config();

// accept and parse JSON content-type
app.use(express.json());

// add language param to request
app.param('language', (req, res, next, value) => {
    req.language = value;
    next();
});

// Find places routes
app.use('/:language', places(tagsRepository));
// Tags routes
app.use('/tags', tags(tagsRepository));
// Photo 
app.get('/photo/:id', async (req, res) => {
    try {
        const maxHeight = req.query.maxheight;
        const maxWidth = req.query.maxwidth;

        const response = await getPhoto(req.params.id, maxHeight, maxWidth);
        const photo = Buffer.from(response.body, 'base64');

        res.header(response.headers);
        res.send(photo);
    }
    catch (err) {
        if (err instanceof ValidationError) {
            res.status(400);
            res.send(err.message);
        } else {
            res.status(500);
            res.send(err.message);
        }
    }
});

app.listen(3000);

//todo export to cloud function