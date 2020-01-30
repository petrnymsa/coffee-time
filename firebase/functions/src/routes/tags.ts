import express = require('express');

const router = express.Router();

router.get('/', (req, res) => {

    res.send('All tags');
});

router.get('/:placeId', (req, res) => {

    res.send(`Getting tags for ${req.params.placeId}`);
});

router.post('/:placeId', (req, res) => {

    res.send(`Update tags for ${req.params.placeId}`);
});

module.exports = router;