PHONY: bundle.js

bundle.rb: app.rb src/prism.rb
	cat src/prism.rb app.rb > bundle.rb

bundle.c: bundle.rb
	./mruby/bin/mrbc -Bbundle bundle.rb

mruby-build:
	cd mruby && make

patch-mruby:
	cd mruby && cat ../mruby.patch | git apply --reject --whitespace=fix

unpatch-mruby:
	cd mruby && git checkout . && git clean -f && cd ..

bundle.js: main.c bundle.c
	emcc -s ALLOW_MEMORY_GROWTH=1 -s EXPORTED_FUNCTIONS="['_main', '_render', '_dispatch', '_event']" -s EXTRA_EXPORTED_RUNTIME_METHODS='["ccall", "cwrap"]' -s WASM=1 -I mruby/include main.c mruby/build/emscripten/lib/libmruby.a -o bundle.js && echo "Done."

clean:
	rm bundle.js bundle.c

server:
	node wasm-server.js

