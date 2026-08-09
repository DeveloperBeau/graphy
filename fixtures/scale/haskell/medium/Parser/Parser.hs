module Parser.Parser (parse) where

import Lexer.Token (Token(..))
import Parser.Ast (Expr(..))
import Parser.Precedence (level)

parse :: [Token] -> Expr
parse ts = fst (expr ts 0)

expr :: [Token] -> Int -> (Expr, [Token])
expr ts minp =
  let (lhs, rest) = atom ts
  in climb lhs rest minp

climb :: Expr -> [Token] -> Int -> (Expr, [Token])
climb lhs (TOp o : rest) minp
  | level o >= minp =
      let (rhs, rest') = expr rest (level o + 1)
      in climb (BinOp o lhs rhs) rest' minp
climb lhs ts _ = (lhs, ts)

atom :: [Token] -> (Expr, [Token])
atom (TNum n : rest) = (Lit n, rest)
atom (TIdent nm : TLParen : rest) =
  let (args, rest') = argList rest
  in (Call nm args, rest')
atom (TIdent nm : rest) = (Var nm, rest)
atom ts = (Lit 0, ts)

argList :: [Token] -> ([Expr], [Token])
argList (TRParen : rest) = ([], rest)
argList ts =
  let (e, rest) = expr ts 0
  in case rest of
       (TComma : more) -> let (es, r) = argList more in (e : es, r)
       (TRParen : more) -> ([e], more)
       _ -> ([e], rest)
