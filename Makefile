dist/prism.js: src/prism.js
	npx browserify src/prism.js -o dist/prism.js

runtime:
	./script/build-prism-runtime

mruby-build:
	cd mruby && make

patch-mruby:
	cd mruby && cat ../mruby.patch | git apply --reject --whitespace=fix

unpatch-mruby:
	cd mruby && git checkout . && git clean -f && cd ..
