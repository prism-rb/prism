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
    fetchAndLoad(main),
  ];

  load(modulesToLoad, main, config);
}

let _refId = 1;

const references = new Map();
let args = [];

function clearArgs() {
  args = [];
}

function setArgString(index, value) {
  args[index] = value;
}

function setArgNumber(index, value) {
  args[index] = value;
}

let callbackArgs = [];

const registry = new FinalizationRegistry(cleanupReference);

function cleanupReference(reference) {
  Module.ccall("cleanup_reference", "void", ["int"], [reference]);
}

function setArgCallback(index, reference) {
  function callbackHandler(...args) {
    callbackArgs = args;
    Module.ccall("handle_callback", "void", ["int"], [reference]);
  };

  args[index] = callbackHandler;

  registry.register(callbackHandler, reference);
}

function setObjectValue(reference, name, value) {
  const referenceValue = references.get(reference);

  try {
    referenceValue[name] = value;
  } catch (e) {
    console.error(e);
    Module.ccall("print_backtrace", "void", ["string"], [e.message]);
  }
}


function getReference(obj) {
  if (obj == null) {
    return 0;
  }

  const refId = _refId++;

  references.set(refId, obj);

  return refId;
}

function getWindowReference() {
  return getReference(window);
}


function getDocumentReference() {
  return getReference(document);
}


function callMethod(reference, methodName) {
  const value = references.get(reference);

  try {
    if (!value) {
      throw new Error(
        `Attempted to call ${methodName} on invalid reference: ${reference}`
      );
    }

    value[methodName].apply(value, args);
  } catch (e) {
    console.error(e);
    Module.ccall("print_backtrace", "void", ["string"], [e.message]);
  }
}

function callMethodReturningReference(reference) {
  const value = references.get(reference);

  try {
    if (!value) {
      throw new Error(`Attempted to call invalid reference: ${reference}, ${value}`);
    }

    return getReference(value(...args));
  } catch (e) {
    console.error(e);
    Module.ccall("print_backtrace", "void", ["string"], [e.message]);
  }
}


function getValueString(reference) {
  const value = references.get(reference);

  try {
    return value.toString();
  } catch (e) {
    console.error(e);
    Module.ccall("print_backtrace", "void", ["string"], [e.message]);
  }
}

function getValueReference(reference, property) {
  const value = references.get(reference);

  try {
    if (!value) {
      throw new Error(
        `Attempted to look up ${property} on invalid reference: ${reference}`
      );
    }

    return getReference(value[property]);
  } catch (e) {
    console.error(e);
    Module.ccall("print_backtrace", "void", ["string"], [e.message]);
  }
}

function getTypeOf(reference) {
  const value = references.get(reference);

  try {
    return typeof value;
  } catch (e) {
    console.error(e);
    Module.ccall("print_backtrace", "void", ["string"], [e.message]);
  }
}

function getArgCount() {
  try {
    return callbackArgs.length;
  } catch (e) {
    console.error(e);
    Module.ccall("print_backtrace", "void", ["string"], [e.message]);
  }
}

function getArgString(index) {
  const value = callbackArgs[index];

  try {
    return value.toString();
  } catch (e) {
    console.error(e);
    Module.ccall("print_backtrace", "void", ["string"], [e.message]);
  }
}

function getArgNumber(index) {
  const value = callbackArgs[index];

  try {
    return value;
  } catch (e) {
    console.error(e);
    Module.ccall("print_backtrace", "void", ["string"], [e.message]);
  }
}

function getArgReference(index) {
  const value = callbackArgs[index];

  try {
    return getReference(value);
  } catch (e) {
    console.error(e);
    Module.ccall("print_backtrace", "void", ["string"], [e.message]);
  }
}

function getArgClassName(index) {
  const value = callbackArgs[index];

  try {
    if (!value || !value.constructor) {
      return "";
    }

    return value.constructor.name;
  } catch (e) {
    console.error(e);
    Module.ccall("print_backtrace", "void", ["string"], [e.message]);
  }
}

window.Prism = {
  run,
  eval: _eval,
  setArgString,
  setArgNumber,
  setArgCallback,
  setObjectValue,
  clearArgs,
  getValueReference,
  getValueString,
  callMethod,
  callMethodReturningReference,
  render,
  stringifyEvent,
  getWindowReference,
  getDocumentReference,
  getArgCount,
  getArgString,
  getArgNumber,
  getArgReference,
  getArgClassName,
  getTypeOf
};

function render() {
  const rvtree = JSON.parse(Module.ccall("render", "string", []));
  const vtree = rubyVTreeToSnabbdom(rvtree);

  patch(currentContainer, vtree);

  currentContainer = vtree;
}

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

function _eval(s) {
  return Module.ccall("eval", "string", ["string"], [s]);
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
