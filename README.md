# bnfgen-js

JavaScript bindings for the [BNFGen](https://baturin.org/tools/bnfgen) library.

Features:

* Familiar BNF-like syntax for grammar descriptions.
* Control over the generation process.
* Debugging/tracing options.

Grammar example:

```
# You can add "weights" to your rules.
# The recursive "<symbol> <start>" alternative will be taken 10 times more often
# to produce longer sequences.
<start> ::= <symbol> | 10 <symbol> <start> ;

# Deterministic repetition: up to 10 of "foo" or exactly two of "baz".
<symbol> ::= <fooOrBar>{1,10} | "baz"{2} ;

<fooOrBar> ::= "foo" | "bar"
```

## Install 

```
$ npm install bnfgen
```

## Use in a web browser

The `bnfgen_browser.js` file is a browser library that "exports" a `window.bnfgen` object.

## Usage

```javascript
var bnfgen = require('bnfgen');

// Parse and load a grammar
bnfgen.loadGrammar('<start> ::= <greeting> "world"; <greeting> = "hello" | "hi"');

// Set symbol separator to space (default is '')
bnfgen.symbolSeparator = ' ';

// bnfgen.generate function requires a start symbol
bnfgen.generate('start') // generates "hello world" or "hi world"
bnfgen.generate('greeting') // generates "hello" or "hi"

//// Limits

// Maximum number of reductions you allow to perform
// (bnfgen will raise an error if it's exceeded)
// 0 means no limit
bnfgen.maxReductions = 0

// Maximum number of reductions that don't produce any terminals
maxNonproductiveReductions = 0

//// Debug options

// Log symbol reductions
bnfgen.debug = false

// Also log current symbol stack at every
bnfgen.dumpStack = false

// You can supply a custom logging function instead of the default console.log
bnfgen.debugFunction = console.log
```

## Building the JS files from the OCaml source

```
opam install ocamlfind bnfgen js_of_ocaml js_of_ocaml-ppx

make all
```
