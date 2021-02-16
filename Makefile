bnfgen_module.js: src/bnfgen_common.ml src/bnfgen_module.ml
	ocamlfind ocamlc -package bnfgen,js_of_ocaml,js_of_ocaml-ppx -linkpkg -I src/ -o bnfgen_module.byte src/bnfgen_common.ml src/bnfgen_module.ml
	js_of_ocaml bnfgen_module.byte
	rm bnfgen_module.byte

bnfgen_browser.js: src/bnfgen_common.ml src/bnfgen_browser.ml
	ocamlfind ocamlc -package bnfgen,js_of_ocaml,js_of_ocaml-ppx -linkpkg -I src/ -o bnfgen_browser.byte src/bnfgen_common.ml src/bnfgen_browser.ml
	js_of_ocaml bnfgen_browser.byte
	rm bnfgen_browser.byte

clean:
	rm -f src/*.cmi src/*.cmo
	rm -f *.js

all: bnfgen_module.js bnfgen_browser.js
