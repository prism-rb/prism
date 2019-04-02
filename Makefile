test.c: test.rb
	mrbc -Btest test.rb

test.js: test.wasm test.c
	emcc -I mruby/include main.c mruby/build/emscripten/lib/libmruby.a -o test.js

server:
	node wasm-server.js

PHONY: test.js
