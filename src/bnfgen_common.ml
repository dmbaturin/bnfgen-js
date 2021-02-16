module Js = Js_of_ocaml.Js


let js_fail msg = new%js Js.error_constr (Js.string msg) |> Js.raise_js_error

let or_fail v =
  match v with
  | Ok v -> v
  | Error msg -> js_fail msg

let int_to_limit n =
  if n = 0 then None else Some n

let bnfgen_object =
  (object%js (self)
    val mutable grammar = None

    val mutable debug = false
    val mutable dumpStack = false
    val mutable maxReductions = 0
    val mutable maxNonproductiveReductions = 0
    val mutable symbolSeparator = Js.string ""
    val mutable debugFunction : Js.Unsafe.any = Js.Unsafe.js_expr "console.log"

    
    method loadGrammar s =
      let s = Js.to_string s in
      let grammar = Bnfgen.grammar_from_string s |> or_fail in
      let () = Bnfgen.check_grammar grammar |> or_fail in
      self##.grammar := Some grammar

    method generate start_symbol =
      let settings = Bnfgen.{
        debug = self##.debug;
        dump_stack = self##.dumpStack;
        debug_fun = (fun msg -> ignore @@ Js.Unsafe.fun_call self##.debugFunction [|Js.string msg |> Js.Unsafe.coerce|]);
        max_reductions = self##.maxReductions |> int_to_limit;
        max_nonproductive_reductions = self##.maxNonproductiveReductions |> int_to_limit;
        symbol_separator = self##.symbolSeparator |> Js.to_string
      }
       in
       let start_symbol = Js.to_string start_symbol in
       match self##.grammar with
       | None -> js_fail "Grammar is not loaded, cannot generate anything."
       | Some grammar ->
         Bnfgen.generate_string ~settings:settings grammar start_symbol |> or_fail |> Js.string
  end)
