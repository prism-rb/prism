const http = require('http');
const fs = require('fs');
const path = require('path');

const proxy = http.createServer((req, res) => {
  console.log(req.url);
  const p = path.join('.', req.url);

  try {
    if (p.endsWith('.wasm')) {
      res.setHeader("Content-Type", "application/wasm")
    }
    res.write(fs.readFileSync(p));
  } catch (e) {
    res.write(e.toString());
  }
  res.end();
});

proxy.listen(1337, '127.0.0.1');
