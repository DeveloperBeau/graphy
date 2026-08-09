open Ast

let apply_op op a b =
  match op with
  | '+' -> a +. b
  | '-' -> a -. b
  | '*' -> a *. b
  | '^' -> a ** b
  | _ -> if b = 0. then 0. else a /. b

let rec eval env node =
  match node with
  | Lit n -> n
  | Var name -> Environment.lookup_var env name
  | Call (fn, args) -> Registry.dispatch fn (List.map (eval env) args)
  | Bin_op (op, a, b) -> apply_op op (eval env a) (eval env b)
