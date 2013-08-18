# NAME

emcc-jsx - Generates JSX wrappers for emscripten (proof of concept)

# RUN

    # apply the patch to emscripten
    emscripten$ git apply < ../emcc-jsx/emscripten.patch

    # then, make test
    emcc-jsx$ make test
