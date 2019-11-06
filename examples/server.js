const express = require('express');

const app = express();

app.get('/', (req, res) => {
  setTimeout(() => {
    res.setHeader("Access-Control-Allow-Origin", "*");
    res.setHeader('Access-Control-Allow-Methods', '*');
    res.setHeader("Access-Control-Allow-Headers", "*");
    res.send('Text, but from the internet!');
    res.end();
  }, 300);
});

app.listen(9001, () => { console.log('listening on 9001') });
