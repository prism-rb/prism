const snabbdom = require("snabbdom");
const patch = snabbdom.init([
  require("snabbdom/modules/class").default,
  require("snabbdom/modules/attributes").default,
  require("snabbdom/modules/props").default,
  require("snabbdom/modules/style").default,
  require("snabbdom/modules/eventlisteners").default,
  require("snabbdom/modules/dataset").default,
]);
const snabbdom_h = require("snabbdom/h").default;

const RUBY_VALUE = Symbol("RUBY_VALUE");

type AnyFunction<T> = (...args: any[]) => T;
type ReferenceToJS = number;
type ReferenceToRuby = number;
type RubyType = "string" | "number" | "null" | "undefined" | "true" | "false" | "js_value" | "array" | "method" | "object";


interface RubyValue {
  [RUBY_VALUE]: ReferenceToRuby;
}

interface WasmModule extends EmscriptenModule {
    ccall: typeof ccall;
}

interface RubyMethod extends RubyValue {
  (...args: any[]): void;
}

interface PrismModule {
  eval(s: string): string;
  run: typeof run;
  setArgString: typeof setArgString;
  setArgNumber: typeof setArgNumber;
  setArgCallback: typeof setArgCallback;
  setArgValue: typeof setArgValue;
  setObjectValue: typeof setObjectValue;
  setObjectValueFromReference: typeof setObjectValueFromReference;
  setObjectValueFromRubyReference: typeof setObjectValueFromRubyReference;
  freeReference: typeof freeReference;
  clearArgs: typeof clearArgs;
  getValueReference: typeof getValueReference;
  getValueString: typeof getValueString;
  getValueNumber: typeof getValueNumber;
  callMethod: typeof callMethod;
  callMethodReturningReference: typeof callMethodReturningReference;
  callConstructor: typeof callConstructor;
  getWindowReference: typeof getWindowReference;
  getPrismBindingsReference: typeof getPrismBindingsReference;
  getDocumentReference: typeof getDocumentReference;
  getArgsReference: typeof getArgsReference;
  getArgCount: typeof getArgCount;
  getArgString: typeof getArgString;
  getArgNumber: typeof getArgNumber;
  getArgReference: typeof getArgReference;
  getArgClassName: typeof getArgClassName;
  getTypeOf: typeof getTypeOf;
  makeCallbackReference: typeof makeCallbackReference;
  getRubyReferenceId: typeof getRubyReferenceId;
  checkIfFunctionIsContructor: typeof checkIfFunctionIsContructor;
  require: typeof prismRequire;
  import: typeof importJS;
}

interface Window {
  Prism: PrismModule;
}

interface RemotePrismModule {
  name: string;
  text: string;
}

declare var Module: WasmModule;

const references = new Map<ReferenceToJS, any>();
let allLoaded = false;
let modulesToLoad = [];
let _refId = 1;
let args: any[] = [];
let callbackArgs: any[] = [];

function run(element: Element, main: string, config = {}) {
  modulesToLoad = [fetchAndLoad("/prism-ruby/prism.rb"), fetchAndLoad(main)];

  load(modulesToLoad, main, config);
}

function clearArgs() {
  args.splice(0, args.length);
}

function setArgString(index: keyof (typeof args), value: string) {
  args[index] = value;
}

function setArgNumber(index: keyof (typeof args), value: string) {
  args[index] = value;
}

const registry = new FinalizationRegistry(cleanupReference);

function tryCatchThrow<T>(f: AnyFunction<T>): T {
  try {
    return f();
  } catch (e) {
    if (e === "longjmp") {
      throw e;
    }
    console.error(e);
    if (e instanceof Error) {
      Module.ccall("print_backtrace", null, ["string"], [e.message]);
    }
    throw e;
  }
}

function cleanupReference(reference: ReferenceToJS) {
  Module.ccall("cleanup_reference", null, ["number"], [reference]);
}

function makeCallbackReference<Args extends Array<Args>>(callbackReference: ReferenceToJS) {
  function callbackHandler(...args: Args) {
    callbackArgs = args;
    Module.ccall("handle_callback", null, ["number"], [callbackReference]);
  }

  (callbackHandler as RubyMethod)[RUBY_VALUE] = callbackReference;

  registry.register(callbackHandler, callbackReference);

  return getReference(callbackHandler);
}

function setArgCallback(index: number, reference: ReferenceToRuby) {
  function callbackHandler(...args: any[]) {
    callbackArgs = args;
    Module.ccall("handle_callback", null, ["number"], [reference]);
  }

  args[index] = callbackHandler;

  registry.register(callbackHandler, reference);
}

function setArgValue(index: number, reference: ReferenceToJS) {
  const referenceValue = lookupReference(reference);

  tryCatchThrow(() => {
    args[index] = referenceValue;
  });
}

function setObjectValue(reference: ReferenceToJS, name: string, value: any) {
  const referenceValue = lookupReference(reference);

  tryCatchThrow(() => {
    referenceValue[name] = value;
  });
}

function setObjectValueFromReference(reference: ReferenceToJS, name: string, valueReference: ReferenceToJS) {
  const obj = lookupReference(reference);
  const value = lookupReference(valueReference);

  tryCatchThrow(() => {
    obj[name] = value;
  });
}

function makeInnerRubyValue(rubyReferenceId: ReferenceToRuby, rubyType: RubyType) {
  if (rubyType === "array") {
    return [];
  }

  if (rubyType === "object") {
    return {};
  }

  return function value(...args: any[]) {
    // call my current reference
    // just return a damn ruby value, worry about primitive promotion later
    callbackArgs = args;

    const newRubyReferenceId = Module.ccall(
      "call_ruby_value_returning_reference",
      "number",
      ["number"],
      [rubyReferenceId]
    );

    const rubyType = Module.ccall(
      "get_ruby_reference_type",
      "string",
      ["number"],
      [newRubyReferenceId]
    );

    if (rubyType === "js_value") {
      const jsReferenceId = Module.ccall(
        "get_ruby_reference_number",
        "number",
        ["string", "number"],
        ["value", rubyReferenceId]
      );

      return lookupReference(jsReferenceId);
    }

    return makeRubyValue(newRubyReferenceId);
  };
}

function makeRubyValue(rubyReferenceId: ReferenceToRuby): RubyValue {
  const rubyType = Module.ccall(
    "get_ruby_reference_type",
    "string",
    ["number"],
    [rubyReferenceId]
  ) as RubyType;

  const value = makeInnerRubyValue(rubyReferenceId, rubyType);

  (value as RubyValue)[RUBY_VALUE] = rubyReferenceId;

  const proxyMethods = {
    set: function setPropertyOnRubyValue(obj: any, prop: string, value: any) {
      const jsValue = getReference(value);

      Prism.eval(`
        Prism::ExternalReferences.set_ruby_value_property(${rubyReferenceId}, ${JSON.stringify(
        prop,
        null,
        2
      )}, ${jsValue})
      `);

      // TODO - we should have a bool result to indicate sucess
      return true;
    },
    get: function getPropertyOnRubyValue(obj: any, prop: string | symbol): any {
      if (prop === RUBY_VALUE) {
        return obj[prop];
      }

      if (prop === Symbol.iterator) {
        prop = "each";

        const rubyType = Module.ccall(
          "get_ruby_reference_property_type",
          "string",
          ["string", "number"],
          [prop, rubyReferenceId]
        );

        if (rubyType !== "method") {
          throw new Error(
            "Ruby value does not implement #each and cannot be iterated"
          );
        }

        const iteratorReference = Module.ccall(
          "get_ruby_iterator_reference",
          "number",
          ["number"],
          [rubyReferenceId]
        );

        return makeRubyValue(iteratorReference);
      }

      if (Symbol.toPrimitive && prop === Symbol.toPrimitive) {
        return ({} as any)[Symbol.toPrimitive];
      }

      if (typeof prop === "symbol") {
        throw new Error("unhandled symbol prop acces on ruby value: " + prop.toString());
      }

      return accessProperty(rubyValue, rubyReferenceId, rubyType, prop);
    },
  };

  const rubyValue = new Proxy(value, proxyMethods);
  registry.register(rubyValue, rubyReferenceId);
  return rubyValue;
}

function accessProperty(value: RubyValue, rubyReferenceId: ReferenceToRuby, rubyType: RubyType, prop: string) {
  return tryCatchThrow(() => {
    const propertyRubyType = Module.ccall(
      "get_ruby_reference_property_type",
      "string",
      ["string", "number"],
      [prop, rubyReferenceId]
    );

    if (rubyType === "array" && prop === "length") {
      callbackArgs = [];

      const methodRubyReferenceId = Module.ccall(
        "get_ruby_method_reference",
        "number",
        ["string", "number"],
        [prop, rubyReferenceId]
      );

      const resultReferenceId = Module.ccall(
        "call_ruby_value_returning_reference",
        "number",
        ["number"],
        [methodRubyReferenceId]
      );

      const result = Module.ccall(
        "get_ruby_reference_as_int",
        "number",
        ["number"],
        [resultReferenceId]
      );

      cleanupReference(methodRubyReferenceId);
      cleanupReference(resultReferenceId);

      return result;
    }

    if (propertyRubyType === "number") {
      return Module.ccall(
        "get_ruby_reference_number",
        "number",
        ["string", "number"],
        [prop, rubyReferenceId]
      );
    }

    if (propertyRubyType === "string") {
      return Module.ccall(
        "get_ruby_reference_string",
        "string",
        ["string", "number"],
        [prop, rubyReferenceId]
      );
    }

    if (propertyRubyType === "null") {
      return null;
    }

    if (propertyRubyType === "undefined") {
      return undefined;
    }

    if (propertyRubyType === "method") {
      const methodRubyReferenceId = Module.ccall(
        "get_ruby_method_reference",
        "number",
        ["string", "number"],
        [prop, rubyReferenceId]
      );

      return makeRubyValue(methodRubyReferenceId);
    }

    if (propertyRubyType === "true") {
      return true;
    }

    if (propertyRubyType === "false") {
      return false;
    }

    if (propertyRubyType === "js_value") {
      const jsReferenceIdString = Prism.eval(`
        Prism::ExternalReferences.get_js_value_reference_number(${JSON.stringify(
          prop,
          null,
          2
        )}, ${rubyReferenceId})
      `);

      return references.get(parseInt(jsReferenceIdString, 10));
    }

    if (propertyRubyType === "object" || propertyRubyType === "array") {
      const newRubyReferenceId = Prism.eval(`
        Prism::ExternalReferences.get_ruby_property_object(${JSON.stringify(
          prop
        )}, ${rubyReferenceId})
      `);

      return makeRubyValue(parseInt(newRubyReferenceId, 10));
    }

    throw new Error("unhandled ruby type: " + propertyRubyType);
  });
}

function setObjectValueFromRubyReference(reference: ReferenceToJS, name: string, rubyReferenceId: ReferenceToRuby) {
  const obj = lookupReference(reference);
  const value = makeRubyValue(rubyReferenceId);

  tryCatchThrow(() => {
    obj[name] = value;
  });
}

function getReference(obj: any): ReferenceToJS {
  if (obj === null) {
    return 0;
  }

  const refId = _refId++;

  references.set(refId, obj);

  return refId;
}

function freeReference(refId: ReferenceToJS) {
  references.delete(refId);
}

function getWindowReference() {
  return getReference(window);
}

function getPrismBindingsReference() {
  return getReference(Prism);
}

function getDocumentReference() {
  return getReference(document);
}

function getArgsReference() {
  return getReference(args);
}

function callMethod(reference: ReferenceToJS, methodName: string) {
  const value = lookupReference(reference);

  tryCatchThrow(() => {
    if (!value) {
      throw new Error(
        `Attempted to call ${methodName} on invalid reference: ${reference}`
      );
    }

    value[methodName].apply(value, args);
  });
}

function callMethodReturningReference(thisReference: ReferenceToJS, reference: ReferenceToJS) {
  const thisValue = lookupReference(thisReference);
  const value = lookupReference(reference);

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

function callConstructor(reference: ReferenceToJS) {
  const value = lookupReference(reference);

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

function lookupReference(reference: ReferenceToJS) {
  return references.get(reference);
}

function getValueString(reference: ReferenceToRuby) {
  const value = lookupReference(reference);

  return tryCatchThrow(() => {
    return value.toString();
  });
}

function getValueNumber(reference: ReferenceToJS) {
  const value = lookupReference(reference);

  return tryCatchThrow(() => {
    return Number(value);
  });
}

function getValueReference(reference: ReferenceToJS, property: string) {
  const value = lookupReference(reference);
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

function getTypeOf(reference: ReferenceToJS): string {
  const value = lookupReference(reference);

  return tryCatchThrow(() => {
    const type = typeof value;

    if ((type === "object" || type === "function") && RUBY_VALUE in value) {
      return "ruby_value";
    }

    return typeof value;
  });
}

function getRubyReferenceId(reference: ReferenceToJS): ReferenceToRuby {
  const value = lookupReference(reference);

  return tryCatchThrow(() => {
    return value[RUBY_VALUE];
  });
}

function checkIfFunctionIsContructor(reference: ReferenceToJS) {
  const value = lookupReference(reference);

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

function getArgCount(): number {
  return tryCatchThrow(() => callbackArgs.length);
}

function getArgString(index: number): string {
  return tryCatchThrow(() => callbackArgs[index].toString());
}

function getArgNumber(index: number): number {
  return callbackArgs[index];
}

function getArgReference(index: number): ReferenceToJS {
  const value = callbackArgs[index];

  return tryCatchThrow(() => {
    return getReference(value);
  });
}

function getArgClassName(index: number): string {
  const value = callbackArgs[index];

  return tryCatchThrow(() => {
    if (!value || !value.constructor) {
      return "";
    }

    return value.constructor.name;
  });
}

const Prism: PrismModule = {
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
  getWindowReference,
  getPrismBindingsReference,
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
  import: importJS,
};

window.Prism = Prism;

function importJS(url: string) {
  return import(url);
}

function fetchAndLoad(name: string) {
  return fetch(name)
    .then((r) => r.text().then((t) => ({ ok: r.ok, text: t })))
    .then(({ ok, text }) => {
      if (!ok) {
        throw new Error(`Prism: Could not load ${name}: ${text}`);
      }

      return { name, text };
    });
}

function _eval(s: string) {
  return Module.ccall("eval", "string", ["string"], [s]);
}

async function prismRequire(cb: () => void, ...paths: string[]) {
  for (const path of paths) {
    await fetchAndLoad(path).then((module) => {
      writeModule(module.name, module.text);
      Module.ccall("load_ruby", "number", ["string"], [module.name]);
    });
  }

  cb();
}

const require_regex = /require(_relative)?\s*\(?\s*['|"]([^'|"]+)/;

function transformModule(moduleText: string) {
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

      const bodyText = lines
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

function writeModule(name: string, text: string) {
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

function load(modulesToLoad: Promise<RemotePrismModule>[], main: string, config = {}) {
  modulePromise.then(() => {
    Promise.all(modulesToLoad).then((modules) => {
      for (let m of modules) {
        writeModule(m.name, m.text);
      }

      Module.ccall(
        "load",
        "number",
        ["string", "string"],
        [main, JSON.stringify(config)]
      );
    });
  });
}

window.addEventListener("unhandledrejection", function (event) {
  if (event.reason === "longjmp") {
    event.preventDefault();
    event.stopPropagation();
  }
});

const modulePromise = new Promise((resolve, reject) => {
  window.Module = {
    preRun: [],
    postRun: [resolve as () => void],
    print: (function () {
      return function (e: string) {
        1 < arguments.length &&
          (e = Array.prototype.slice.call(arguments).join(" ")),
          console.log(e);
      };
    })(),
    printErr: function (e: string) {
      1 < arguments.length &&
        (e = Array.prototype.slice.call(arguments).join(" ")),
        console.error(e);
    },
    canvas: (function () {})(),
    setStatus: function () {},
    totalDependencies: 0,
    monitorRunDependencies: function () {},
  } as any;
});
