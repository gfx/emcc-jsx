
EMCC := "../emscripten/emcc"

test:
	prove t/*.pl

add.js: add.c
	$(EMCC) -s LINKABLE=1 -o $@ $<
