const http = require('http');
const fs = require('fs');
const path = require('path');

function renderFileLink(p, name) {
  return `<li><a href="${path.join(p, name)}">${name}</a></li>`;
}

function isDirectory(p) {
  try {
    return fs.statSync(p).isDirectory();
  } catch (e) {
    return false;
  }
}

const port = parseInt(process.argv[2], 10) || 3042;
const host = process.argv[3] || '127.0.0.1';
const proxy = http.createServer((req, res) => {
  let p = path.join('.', req.url);

  console.log(p);

  if (p.startsWith('prism-assets')) {
    p = path.join(__dirname, 'build', path.basename(p));
  }

  if (p.startsWith('prism-ruby/bindings')) {
    p = path.join(__dirname, 'bindings', path.basename(p));
  }

  if (p.startsWith('prism-ruby')) {
    p = path.join(__dirname, 'src', path.basename(p));
  }

  if (isDirectory(p)) {
    const files = fs.readdirSync(p);

    res.write(`
<!DOCTYPE html>
<html lang=en-us>

<head>
  <meta charset=utf-8>
  <meta content="text/html; charset=utf-8" http-equiv=Content-Type>
  <title>Prism Server</title>
  <style>
    html, body {
      font-family: sans-serif;
    }
  </style>
</head>

  <body>
    <h1>Prism Dev Server</h1>
    <h2>${path.join(process.cwd(), p)}</h2>

    <ul>
      ${files.map(f => renderFileLink(req.url, f)).join("\n")}
    </ul>

  </body>
</html>
    `);
    res.end();
    return;
  }

  try {
    if (p.endsWith('.wasm')) {
      res.setHeader("Content-Type", "application/wasm")
    }
    if (p.endsWith('.js')) {
      res.setHeader("Content-Type", "text/javascript")
    }
    if (p.endsWith('.rb') && req.headers.accept.includes("text/html")) {
      res.write(`
<!DOCTYPE html>
<html lang=en-us>

<head>
  <meta charset=utf-8>
  <meta content="text/html; charset=utf-8" http-equiv=Content-Type>
</head>
  <body>
    <div id="root"></div>
  </body>
  <script type="text/javascript" src="/prism-assets/prism.js"></script>
  <script type="text/javascript" async src="/prism-assets/bundle.js"></script>
  <script type="text/javascript">
    Prism.run(document.getElementById("root"), "/${p}");
  </script>
</html>
      `);
      res.end();
      return;
    }
    if (p.endsWith('rb')) {
      res.setHeader('Content-Type', "application/ruby");
    }
    res.write(fs.readFileSync(p));
  } catch (e) {
    res.write(e.toString());
  }
  res.end();
});

console.log(`Listening on ${host}:${port}`);
proxy.listen(port, host);
