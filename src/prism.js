var snabbdom = require("snabbdom");
var patch = snabbdom.init([
  require("snabbdom/modules/class").default,
  require("snabbdom/modules/attributes").default,
  require("snabbdom/modules/props").default,
  require("snabbdom/modules/style").default,
  require("snabbdom/modules/eventlisteners").default,
  require("snabbdom/modules/dataset").default,
]);
var snabbdom_h = require("snabbdom/h").default;


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
  modulesToLoad = [fetchAndLoad("/prism-ruby/prism.rb"), fetchAndLoad(main)];

  load(modulesToLoad, main, config);
}

let _refId = 1;

const references = new Map();
let args = [];

function clearArgs() {
  args.splice(0, args.length);
}

function setArgString(index, value) {
  args[index] = value;
}

function setArgNumber(index, value) {
  args[index] = value;
}

const RUBY_VALUE = Symbol("RUBY_VALUE");

let callbackArgs = [];

const registry = new FinalizationRegistry(cleanupReference);

function tryCatchThrow(f) {
  try {
    return f();
  } catch (e) {
    if (e === "longjmp") {
      throw e;
    }
    console.error(e);
    Module.ccall("print_backtrace", "void", ["string"], [e.message]);
    throw e;
  }
}

function cleanupReference(reference) {
  Module.ccall("cleanup_reference", "void", ["int"], [reference]);
}

function makeCallbackReference(callbackReference) {
  function callbackHandler(...args) {
    callbackArgs = args;
    Module.ccall("handle_callback", "void", ["int"], [callbackReference]);
  }

  callbackHandler[RUBY_VALUE] = callbackReference;

  registry.register(callbackHandler, callbackReference);

  return getReference(callbackHandler);
}

function setArgCallback(index, reference) {
  function callbackHandler(...args) {
    callbackArgs = args;
    Module.ccall("handle_callback", "void", ["int"], [reference]);
  }

  args[index] = callbackHandler;

  registry.register(callbackHandler, reference);
}

function setArgValue(index, reference) {
  const referenceValue = references.get(reference);

  tryCatchThrow(() => {
    args[index] = referenceValue;
  });
}

function setObjectValue(reference, name, value) {
  const referenceValue = references.get(reference);

  tryCatchThrow(() => {
    referenceValue[name] = value;
  });
}

function setObjectValueFromReference(reference, name, valueReference) {
  const obj = references.get(reference);
  const value = references.get(valueReference);

  tryCatchThrow(() => {
    obj[name] = value;
  });
}

function makeRubyValue(rubyReferenceId) {
  function value (...args) {
    // call my current reference
    // just return a damn ruby value, worry about primitive promotion later
    callbackArgs = args;

    const newRubyReferenceId = Module.ccall(
      "call_ruby_value_returning_reference",
      "int",
      ["int"],
      [rubyReferenceId]
    );

    const rubyType = Module.ccall(
      "get_ruby_reference_type",
      "string",
      ["int"],
      [newRubyReferenceId]
    );

    if (rubyType === 'js_value') {
      const jsReferenceId = Module.ccall(
        "get_ruby_reference_number",
        "float",
        ["string", "int"],
        ["value", rubyReferenceId]
      );

      return references.get(jsReferenceId);
    }

    return makeRubyValue(newRubyReferenceId);
  }

  value[RUBY_VALUE] = rubyReferenceId;

  const proxyMethods = {
    get: function (obj, prop) {
      if (prop === RUBY_VALUE) {
        return obj[prop];
      }

      if (prop === Symbol.iterator) {
        prop = "each";

        const rubyType = Module.ccall(
          "get_ruby_reference_property_type",
          "string",
          ["string", "int"],
          [prop, rubyReferenceId]
        );

        if (rubyType !== 'method') {
          throw new Error('Ruby value does not implement #each and cannot be iterated');
        }

        const iteratorReference = Module.ccall(
          "get_ruby_iterator_reference",
          "int",
          ["int"],
          [rubyReferenceId]
        );

        return makeRubyValue(iteratorReference);
      }

      if (Symbol.toPrimitive && prop === Symbol.toPrimitive) {
        return {}[Symbol.toPrimitive];
      }

      return tryCatchThrow(() =>{
        const rubyType = Module.ccall(
          "get_ruby_reference_property_type",
          "string",
          ["string", "int"],
          [prop, rubyReferenceId]
        );

        if (rubyType === 'number') {
          return Module.ccall(
            "get_ruby_reference_number",
            "float",
            ["string", "int"],
            [prop, rubyReferenceId]
          );
        } else if (rubyType === 'string') {
          return Module.ccall(
            "get_ruby_reference_string",
            "string",
            ["string", "int"],
            [prop, rubyReferenceId]
          );
        } else if (rubyType === 'null') {
          return null;
        } else if (rubyType === 'method') {
          const methodRubyReferenceId =  Module.ccall(
            "get_ruby_method_reference",
            "int",
            ["string", "int"],
            [prop, rubyReferenceId]
          );

          return makeRubyValue(methodRubyReferenceId);
        } else if (rubyType === 'true') {
          return true;
        } else if (rubyType === 'false') {
          return false;
        } else if (rubyType === 'js_value') {
          const jsReferenceIdString = Prism.eval(`
            Prism::ExternalReferences.get_js_value_reference_number(${JSON.stringify(prop, null, 2)}, ${rubyReferenceId})
          `);

          return references.get(parseInt(jsReferenceIdString, 10));
        } else if (rubyType === "object") {
          const newRubyReferenceId = Prism.eval(`
            Prism::ExternalReferences.get_ruby_property_object(${JSON.stringify(prop)}, ${rubyReferenceId})
          `);

          return makeRubyValue(parseInt(newRubyReferenceId, 10));
        } else {
          throw new Error('unhandled ruby type: ' + rubyType);
        }
      })
    },
  };

  const rubyValue = new Proxy(value, proxyMethods);
  registry.register(rubyValue, rubyReferenceId);
  return rubyValue;
}

function setObjectValueFromRubyReference(reference, name, rubyReferenceId) {
  const obj = references.get(reference);
  const value = makeRubyValue(rubyReferenceId);

  tryCatchThrow(() => {
    obj[name] = value;
  });
}

function getReference(obj) {
  if (obj == null) {
    return 0;
  }

  const refId = _refId++;

  references.set(refId, obj);

  return refId;
}

function freeReference(refId) {
  references.delete(refId);
}

function getWindowReference() {
  return getReference(window);
}

function getDocumentReference() {
  return getReference(document);
}

function getArgsReference() {
  return getReference(args);
}

function callMethod(reference, methodName) {
  const value = references.get(reference);

  tryCatchThrow(() => {
    if (!value) {
      throw new Error(
        `Attempted to call ${methodName} on invalid reference: ${reference}`
      );
    }

    value[methodName].apply(value, args);
  });
}

function callMethodReturningReference(thisReference, reference) {
  const thisValue = references.get(thisReference);
  const value = references.get(reference);

  return tryCatchThrow(() => {
    if (!value || !thisValue) {
      throw new Error(
        `Attempted to call invalid reference: ${thisReference}, ${reference}, ${value}`
      );
    }

    const result = value.apply(thisValue, args);

    return getReference(result);
  });
}

function callConstructor(reference) {
  const value = references.get(reference);

  return tryCatchThrow(() => {
    if (!value) {
      throw new Error(
        `Attempted to construct invalid reference: ${reference}, ${value}`
      );
    }

    const result = Reflect.construct(value, args);

    return getReference(result);
  });
}

function getValueString(reference) {
  const value = references.get(reference);

  return tryCatchThrow(() => {
    return value.toString();
  });
}

function getValueNumber(reference) {
  const value = references.get(reference);

  return tryCatchThrow(() => {
    return Number(value);
  });
}

function getValueReference(reference, property) {
  const value = references.get(reference);
  return tryCatchThrow(() => {
    // TODO - this breaks on falsey values
    if (!value) {
      throw new Error(
        `Attempted to look up ${property} on invalid reference: ${reference}`
      );
    }

    return getReference(value[property]);
  });
}

function getTypeOf(reference) {
  const value = references.get(reference);

  return tryCatchThrow(() => {
    const type = typeof value;

    if ((type === "object" || type === "function") && RUBY_VALUE in value) {
      return "ruby_value";
    }

    return typeof value;
  });
}

function getRubyReferenceId(reference) {
  const value = references.get(reference);

  return tryCatchThrow(() => {
    return value[RUBY_VALUE];
  });
}

function checkIfFunctionIsContructor(reference) {
  const value = references.get(reference);

  return tryCatchThrow(() => {
    if (value === Symbol) {
      return false;
    }

    return (
      value.prototype &&
      "constructor" in value.prototype &&
      value.prototype.constructor !== Function
    );
  });
}

function getArgCount() {
  return tryCatchThrow(() => callbackArgs.length);
}

function getArgString(index) {
  const value = callbackArgs[index];
  return tryCatchThrow(() => value.toString());
}

function getArgNumber(index) {
  return callbackArgs[index];
}

function getArgReference(index) {
  const value = callbackArgs[index];

  return tryCatchThrow(() => {
    return getReference(value);
  });
}

function getArgClassName(index) {
  const value = callbackArgs[index];

  return tryCatchThrow(() => {
    if (!value || !value.constructor) {
      return "";
    }

    return value.constructor.name;
  });
}

window.Prism = {
  run,
  eval: _eval,
  setArgString,
  setArgNumber,
  setArgCallback,
  setArgValue,
  setObjectValue,
  setObjectValueFromReference,
  setObjectValueFromRubyReference,
  freeReference,
  clearArgs,
  getValueReference,
  getValueString,
  getValueNumber,
  callMethod,
  callMethodReturningReference,
  callConstructor,
  render,
  stringifyEvent,
  getWindowReference,
  getDocumentReference,
  getArgsReference,
  getArgCount,
  getArgString,
  getArgNumber,
  getArgReference,
  getArgClassName,
  getTypeOf,
  makeCallbackReference,
  getRubyReferenceId,
  checkIfFunctionIsContructor,
  require: prismRequire,
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

async function prismRequire(cb, ...paths) {
  for (const path of paths) {
    await fetchAndLoad(path).then((module) => {
      writeModule(module.name, module.text);
      Module.ccall("load_ruby", "number", ["string"], [module.name]);
    });
  }

  cb();
}

require_regex = /require(_relative)?\s*\(?\s*['|"]([^'|"]+)/;

function transformModule(moduleText) {
  const lines = moduleText.split("\n");
  const dependencies = [];

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i];

    const match = line.match(require_regex);
    if (match) {
      dependencies.push(match[2]);
    } else {
      if (dependencies.length === 0) {
        return moduleText;
      }

      bodyText = lines
        .slice(i)
        .map((line) => `  ${line}`)
        .join("\n");

      const result = `async_require([${dependencies
        .map((d) => `"${d}"`)
        .join(",")}]) do\n${bodyText}\nend`;

      return result;
    }
  }

  return moduleText;
}

function writeModule(name, text) {
  const parts = name.split("/").filter((a) => a.trim() !== "");

  const directories = parts.slice(0, -1);
  const basename = parts.slice(-1)[0];

  const pwd = [];
  for (let d of directories) {
    try {
      FS.mkdir("./" + pwd.concat(d).join("/"));
    } catch (e) {}
    pwd.push(d);
  }

  FS.writeFile(`./${name}`, transformModule(text));
}

function load(modulesToLoad, main, config = {}) {
  modulePromise.then(() => {
    Promise.all(modulesToLoad).then((modules) => {
      for (let m of modules) {
        writeModule(m.name, m.text);
      }

      const result = Module.ccall(
        "load",
        "number",
        ["string", "string"],
        [main, JSON.stringify(config)]
      );
      if (result === 0) {
        //render();
      }
    });
  });
}

window.addEventListener('unhandledrejection', function (event) {
  if (event.reason === 'longjmp') {
    event.preventDefault();
    event.stopPropagation();
  }
});

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
