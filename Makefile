default: build/prism.js build/bundle.js

build/prism.js: src/prism.js
	npx browserify src/prism.js -o build/prism.js

build/bundle.js: main.c
	./script/build-prism-runtime

mruby-build:
	cd mruby && MRUBY_CONFIG=emscripten make

patch-mruby:
	cd mruby && cat ../mruby.patch | git apply --reject --whitespace=fix

unpatch-mruby:
	cd mruby && git checkout . && git clean -f && cd ..
