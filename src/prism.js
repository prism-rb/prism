var snabbdom = require("snabbdom");
var patch = snabbdom.init([
  require("snabbdom/modules/class").default,
  require("snabbdom/modules/attributes").default,
  require("snabbdom/modules/props").default,
  require("snabbdom/modules/style").default,
  require("snabbdom/modules/eventlisteners").default,
  require("snabbdom/modules/dataset").default,
]);
snabbdom_h = require("snabbdom/h").default;

function stringifyEvent(e) {
  const obj = {};
  for (let k in e) {
    obj[k] = e[k];
  }
  return JSON.stringify(
    obj,
    (k, v) => {
      if (v instanceof Node) return "Node";
      if (v instanceof Window) return "Window";
      return v;
    },
    " "
  );
}

window.stringifyEvent = stringifyEvent;

function rubyVTreeToSnabbdom(rvtree) {
  if (rvtree.type === "text") {
    return rvtree.content;
  }

  let options = {};

  for (let key in rvtree) {
    if (key === "_children") {
      continue;
    }
    if (key === "_type") {
      continue;
    }
    if (key === "_class") {
      continue;
    }
    if (key === "onClick") {
      continue;
    }
    if (key === "onKeydown") {
      continue;
    }
    if (key === "onInput") {
      continue;
    }

    options[key] = rvtree[key];
  }

  if (options.on) {
    for (let key in options.on) {
      var handler = options.on[key];

      options.on[key] = function (event) {
        if (handler.prevent_default) {
          event.preventDefault();
        }

        if (handler.stop_propagation) {
          event.stopPropagation();
        }

        let args = [];

        for (let arg of handler.args) {
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

        var handlerWithArgs = Object.assign({}, handler, { args });

        if (handlerWithArgs.type) {
          Module.ccall(
            "dispatch",
            "void",
            ["string"],
            [JSON.stringify(handlerWithArgs)]
          );
        }
        render();
      };
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

function run(element, main, config = {}) {
  currentContainer = element;
  modulesToLoad = [
    fetchAndLoad("/prism-ruby/prism.rb"),
    fetchAndLoad("/prism-ruby/bindings/bindings.rb"),
    fetchAndLoad(main),
  ];

  load(modulesToLoad, main, config);
}

let _refId = 0;

const references = new Map();
let windowReference = getReference(window);
let documentReference = getReference(document);
let args = [];


function clearArgs() {
  args = [];
}

function setArgString(index, value) {
  args[index] = value;
}

window.clearArgs = clearArgs;
window.setArgString = setArgString;

function getReference(obj) {
  const refId = _refId++;

  references.set(refId, obj);
}

function getWindowReference() {
  return getReference(window);
}

window.getWindowReference = getWindowReference;

function getDocumentReference() {
  return getReference(document);
}

window.getDocumentReference = getDocumentReference;

function callMethod(reference, methodName) {
  const value = references.get(reference);

  try {
    if (!value) {
      throw new Error(`Attempted to call ${methodName} on invalid reference: ${reference}`);
    }

    value[methodName](...args);
  } catch (e) {
    Module.ccall("print_backtrace", "void", ["string"], [e.message]);
  }
}

window.callMethod = callMethod;

window.Prism = { run };

function render() {
  const rvtree = JSON.parse(Module.ccall("render", "string", []));
  const vtree = rubyVTreeToSnabbdom(rvtree);

  patch(currentContainer, vtree);

  currentContainer = vtree;
}

window.render = render;

function fetchAndLoad(name) {
  return fetch(name)
    .then((r) => r.text().then((t) => ({ ok: r.ok, text: t })))
    .then(({ ok, text }) => {
      if (!ok) {
        throw new Error(`Prism: Could not load ${name}`, text);
      }

      return { name, text };
    });
}

function load(modulesToLoad, main, config = {}) {
  modulePromise.then(() => {
    Promise.all(modulesToLoad).then((modules) => {
      for (let m of modules) {
        const parts = m.name.split("/").filter((a) => a.trim() !== "");

        const directories = parts.slice(0, -1);
        const basename = parts.slice(-1)[0];

        const pwd = [];
        for (let d of directories) {
          try {
            FS.mkdir("./" + pwd.concat(d).join("/"));
          } catch (e) {}
          pwd.push(d);
        }

        FS.writeFile(`./${m.name}`, m.text);
      }

      const result = Module.ccall(
        "load",
        "number",
        ["string", "string"],
        [main, JSON.stringify(config)]
      );
      if (result === 0) {
        render();
      }
    });
  });
}

const modulePromise = new Promise((resolve, reject) => {
  window.Module = {
    preRun: [],
    postRun: [resolve],
    print: (function () {
      return function (e) {
        1 < arguments.length &&
          (e = Array.prototype.slice.call(arguments).join(" ")),
          console.log(e);
      };
    })(),
    printErr: function (e) {
      1 < arguments.length &&
        (e = Array.prototype.slice.call(arguments).join(" ")),
        console.error(e);
    },
    canvas: (function () {})(),
    setStatus: function () {},
    totalDependencies: 0,
    monitorRunDependencies: function (e) {},
  };
});
