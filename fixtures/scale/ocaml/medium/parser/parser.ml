open Token
open Ast

let rec expr tokens minp =
  let lhs, rest = atom tokens in
  climb lhs rest minp

and climb lhs tokens minp =
  match tokens with
  | Top o :: rest when Precedence.level o >= minp ->
    let rhs, rest' = expr rest (Precedence.level o + 1) in
    climb (Bin_op (o, lhs, rhs)) rest' minp
  | _ -> (lhs, tokens)

and atom = function
  | Tnum n :: rest -> (Lit n, rest)
  | Tident name :: Tlparen :: rest ->
    let args, rest' = arg_list rest in
    (Call (name, args), rest')
  | Tident name :: rest -> (Var name, rest)
  | tokens -> (Lit 0., tokens)

and arg_list = function
  | Trparen :: rest -> ([], rest)
  | tokens ->
    let e, rest = expr tokens 0 in
    (match rest with
     | Tcomma :: more ->
       let es, r = arg_list more in
       (e :: es, r)
     | Trparen :: more -> ([ e ], more)
     | _ -> ([ e ], rest))

let parse tokens = fst (expr tokens 0)
