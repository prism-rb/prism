default: build/prism.js build/bundle.js bindings/bindings.0.rb

build/prism.js: src/prism.js
	npx browserify src/prism.js -o build/prism.js

build/bundle.js: main.c
	./script/build-prism-runtime

bindings/bindings.0.rb: ./script/generate-ruby-idl-bindings node_modules/@webref
	./script/generate-ruby-idl-bindings

mruby-build:
	cd mruby && MRUBY_CONFIG=emscripten make

patch-mruby:
	cd mruby && cat ../mruby.patch | git apply --reject --whitespace=fix

unpatch-mruby:
	cd mruby && git checkout . && git clean -f && cd ..
