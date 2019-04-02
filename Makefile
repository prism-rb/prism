PHONY: test.js

test.c: test.rb
	mrbc -Btest test.rb

test.js: test.wasm test.c
	emcc -s WASM=1 -I mruby/include main.c mruby/build/emscripten/lib/libmruby.a -o test.js

clean:
	rm test.js test.c

server:
	node wasm-server.js

