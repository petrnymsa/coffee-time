
declare module 'express-serve-static-core' {
    interface Request {
        language?: string
    }
}

import express = require('express');
const app = express();

const places = require('./routes/places');
const tags = require('./routes/tags');

app.use(express.json());

app.param('language', (req, res, next, value) => {
    req.language = value;
    next();
});

// Find places routes
app.use('/:language', places);
// Tags routes
app.use('/tags', tags);
// Detail
app.get('/detail/:id', (req, res) => {
    const id = req.params.id
    res.send(`detail for ${id}`);
});
// Photo 
app.get('/photo/:id', (req, res) => {
    const id = req.params.id
    res.send(`photo for ${id}`);
});

app.listen(3000);