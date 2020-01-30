import express = require('express');
const app = express();

app.get('/', (req, res) => {
    res.send('hello dsgsdsgda');


});


app.listen(3000);