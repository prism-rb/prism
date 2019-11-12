
# Compiling Prism

Prism uses emscripten and mruby to make a wasm-based Ruby interpreter, as well as browserify and snabbdom to build the JS runtime.

When working on Prism itself, you should use `./bin/prism` rather than the `prism` binary. Since all libraries are relative to the path of the prism binary, any changes you make should apply after running the appropriate build step.

### Prerequisites

Our repo contains a number of submodules, so if these are not already initialized you'll want to do that first.

```bash
git submodule update --init --recursive
```

To build the mruby interpreter or the Prism C runtime, you'll need emscripten 1.38.46.

If you haven't yet installed emscripten 1.38.46, you can do so using `emsdk`.

```bash
git clone https://github.com/emscripten-core/emsdk.git

./emsdk/emsdk install 1.38.46
./emsdk/emsdk activate 1.38.46
```

Then, to activate the emscripten environment, run:

```bash
source ./emsdk/emsdk_env.sh
```

### Building the mruby interpreter

Creates the mruby interpreter object files.

```bash
make patch-mruby && make mruby-build
```

### Building the Prism C runtime

Creates the Prism C runtime, outputs to build/. Requires the mruby interpreter to be built.

```bash
make runtime
```

### Building the JS Runtime

If you change `src/prism.js` you'll need to run rebuild `build/prism.js` to see your changes.

```
make build/prism.js
```
