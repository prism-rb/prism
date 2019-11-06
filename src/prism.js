var snabbdom = require('snabbdom');
var patch = snabbdom.init([
  require('snabbdom/modules/class').default,
  require('snabbdom/modules/attributes').default,
  require('snabbdom/modules/props').default,
  require('snabbdom/modules/style').default,
  require('snabbdom/modules/eventlisteners').default,
  require('snabbdom/modules/dataset').default
]);
snabbdom_h = require('snabbdom/h').default;

function stringifyEvent(e) {
  const obj = {};
  for (let k in e) {
    obj[k] = e[k];
  }
  return JSON.stringify(obj, (k, v) => {
    if (v instanceof Node) return 'Node';
    if (v instanceof Window) return 'Window';
    return v;
  }, ' ');
}

window.stringifyEvent = stringifyEvent;

function rubyVTreeToSnabbdom(rvtree) {
  if (rvtree.type === "text") { return rvtree.content; }

  let options = {};

  for (let key in rvtree) {
    if (key === "_children") { continue; }
    if (key === "_type") { continue; }
    if (key === "_class") { continue; }
    if (key === "onClick") { continue; }
    if (key === "onKeydown") { continue; }
    if (key === "onInput") { continue; }

    options[key] = rvtree[key];
  }

  if (options.on) {
    for (let key in options.on) {
      var handler = options.on[key];

      options.on[key] = function(event) {
        if (handler.prevent_default) {
          event.preventDefault();
        }

        if (handler.stop_propagation) {
          event.stopPropagation();
        }

        let args = [];

        for (let arg of handler.args) {
          if (arg.type === "constant") {
            args.push(arg.value);
          }

          if (arg.type === "event") {
            args.push(serializeEvent(event));
          }

          if (arg.type === "event_data") {
            args.push(event[arg.key]);
          }

          if (arg.type === "target_data") {
            args.push(event.target[arg.key]);
          }
        }

        var handlerWithArgs = Object.assign(
          {},
          handler,
          {args}
        );

        if (handlerWithArgs.type) {
          Module.ccall("dispatch", "void", ["string"], [JSON.stringify(handlerWithArgs)]);
        }
        render();
      }
    }
  }

  return snabbdom_h(
    rvtree._type + (rvtree._class || ""),
    options,
    (rvtree._children || []).map(rubyVTreeToSnabbdom)
  );
}


var currentContainer;
var allLoaded = false;
var modulesToLoad = [];

function run(element, main) {
  currentContainer = document.getElementById('root');
  modulesToLoad = [fetchAndLoad("/prism-ruby/prism.rb"), fetchAndLoad(main)];

  load(modulesToLoad, main);
}

window.Prism = {run};

function render() {
  const rvtree = JSON.parse(Module.ccall("render", "string", []));
  const vtree = rubyVTreeToSnabbdom(rvtree);

  patch(currentContainer, vtree);

  currentContainer = vtree;
}

window.render = render;

function fetchAndLoad(name) {
  return fetch(name).then(r => r.text().then(t => ({ok: r.ok, text: t}))).then(({ok, text}) => {
    if (!ok) {
      throw new Error(`Prism: Could not load ${name}`, text);
    }

    return {name, text};
  });
}

function load(modulesToLoad, main) {
  modulePromise.then(() => {
    Promise.all(modulesToLoad).then((modules) => {
      for (let m of modules) {
        const parts = m.name.split('/').filter(a => a.trim() !== '');

        const directories = parts.slice(0, -1);
        const basename = parts.slice(-1)[0];

        const pwd = [];
        for (let d of directories) {
          FS.mkdir('./' + pwd.concat(d).join('/'));
          pwd.push(d);
        }

        FS.writeFile(`./${m.name}`, m.text);
      }

      Module.ccall("load", "void", ["string"], [main]);
      render();
    });
  });
}

const modulePromise = new Promise((resolve, reject) => {
  window.Module = {
    preRun: [],
    postRun: [ resolve ],
    print: function() {
      return function(e) {
        1 < arguments.length && (e = Array.prototype.slice.call(arguments).join(" ")), console.log(e)
      }
    }(),
    printErr: function(e) {
      1 < arguments.length && (e = Array.prototype.slice.call(arguments).join(" ")), console.error(e)
    },
    canvas: function() {}(),
    setStatus: function() {},
    totalDependencies: 0,
    monitorRunDependencies: function(e) {}
  };
});
