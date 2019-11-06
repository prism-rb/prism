const http = require('http');
const fs = require('fs');
const path = require('path');

const port = parseInt(process.argv[2], 10) || 3042;
const proxy = http.createServer((req, res) => {
  let p = path.join('.', req.url);

  if (req.url === '/') {
    p = path.join('.', 'index.html');
  }

  console.log(p);
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

console.log(`Listening on localhost:${port}`);
proxy.listen(port, '127.0.0.1');
