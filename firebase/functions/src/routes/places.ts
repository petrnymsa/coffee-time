import express = require('express');

const router = express.Router();

router.get('/nearby', (req, res) => {

    res.send(`nearby places, lang: ${req.language}`);
});

router.get('/find', (req, res) => {

    res.send(`Find places, lang: ${req.language}`);
});

module.exports = router;