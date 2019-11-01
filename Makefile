PHONY: bundle.js

dist/prism.js:
	npx browserify src/prism.js -o dist/prism.js

mruby-build:
	cd mruby && make

patch-mruby:
	cd mruby && cat ../mruby.patch | git apply --reject --whitespace=fix

unpatch-mruby:
	cd mruby && git checkout . && git clean -f && cd ..

server:
	node wasm-server.js

