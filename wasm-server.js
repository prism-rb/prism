const http = require('http');
const fs = require('fs');
const path = require('path');

const proxy = http.createServer((req, res) => {
  let p = path.join('.', req.url);

  if (req.url === '/') {
    p = path.join('.', 'index.html');
  }

  try {
    if (p.endsWith('.wasm')) {
      res.setHeader("Content-Type", "application/wasm")
    }
    if (p.endsWith('.js')) {
      res.setHeader("Content-Type", "text/javascript")
    }
    res.write(fs.readFileSync(p));
  } catch (e) {
    res.write(e.toString());
  }
  res.end();
});

console.log("Listening on localhost:3042");
proxy.listen(3042, '127.0.0.1');
