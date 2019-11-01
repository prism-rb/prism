const express = require('express');

const app = express();

app.get('/', (req, res) => {
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader('Access-Control-Allow-Methods', '*');
  res.setHeader("Access-Control-Allow-Headers", "*");
  res.send('Hello potato!');
  res.end();
});

app.listen(9001, () => { console.log('listening on 9001') });
