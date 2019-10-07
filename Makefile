PHONY: test.js

test.c: test.rb
	mrbc -Btest test.rb

mruby-build:
	cd mruby && make

patch-mruby:
	cd mruby && cat ../mruby.patch | git apply

test.js: mruby-build test.c
	em++ \
		-s WASM=1 \
		-O3 \
		--bind \
		--memory-init-file 1 \
		--llvm-lto 3 \
		--llvm-opts 3 \
		--js-opts 1 \
		-s ENVIRONMENT=web \
		-s ALLOW_MEMORY_GROWTH=1 \
		-s AGGRESSIVE_VARIABLE_ELIMINATION=1 \
		-s ABORTING_MALLOC=1 \
		-s NO_EXIT_RUNTIME=1 \
		-s NO_FILESYSTEM=1 \
		-s DISABLE_EXCEPTION_CATCHING=2 \
		-s EXPORTED_RUNTIME_METHODS=[\'UTF8ToString\'] \
		-std=c++11 \
		-I mruby/include \
		-I node_modules/asm-dom/cpp \
		-o test.js \
		src/main.cpp \
		node_modules/asm-dom/cpp/asm-dom.cpp \
		mruby/build/emscripten/lib/libmruby.a \

clean:
	rm test.js test.c

server:
	node wasm-server.js

