
EMCC := "../emscripten/emcc"

all: test test-mt

test-mt:
	gcc test-mt.c
	./a.out > test-mt.c.out
	./emcc-jsx mt19937ar.c temp
	jsx --run test-mt.jsx > test-mt.jsx.out
	diff test-mt.c.out test-mt.jsx.out
	rm a.out test-mt.jsx.out

test:
	prove t/*.pl

add.js: add.c
	$(EMCC) -s LINKABLE=1 -o $@ $<
