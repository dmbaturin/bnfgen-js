# bnfgen-js

JavaScript bindings for the BNFGen library.

## Building

```
opam install ocamlfind bnfgen js_of_ocaml js_of_ocaml-ppx

make all
```

The `bnfgen_module.js` file is an ES5 module suitable for use with node.js/deno or tools like webpack and browserify.

The `bnfgen_browser.js` is a jQuery-style browser library that registers `window.bnfgen` object.
