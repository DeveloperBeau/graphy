defmodule Parser.Parser do
  alias Parser.Ast
  alias Parser.Precedence

  def parse(tokens) do
    {tree, _rest} = expr(tokens, 0)
    tree
  end

  defp expr(tokens, min_prec) do
    {lhs, rest} = atom(tokens)
    climb(lhs, rest, min_prec)
  end

  defp climb(lhs, [{:op, op} | rest], min_prec) do
    prec = Precedence.level(op)

    if prec >= min_prec do
      {rhs, rest2} = expr(rest, prec + 1)
      climb(Ast.binop(op, lhs, rhs), rest2, min_prec)
    else
      {lhs, [{:op, op} | rest]}
    end
  end

  defp climb(lhs, rest, _min_prec), do: {lhs, rest}

  defp atom([{:num, n} | rest]), do: {Ast.lit(n), rest}

  defp atom([{:ident, name}, :lparen | rest]) do
    {args, rest2} = args(rest, [])
    {Ast.call(name, args), rest2}
  end

  defp atom([{:ident, name} | rest]), do: {Ast.var(name), rest}
  defp atom(rest), do: {Ast.lit(0.0), rest}

  defp args([:rparen | rest], acc), do: {Enum.reverse(acc), rest}

  defp args(tokens, acc) do
    {e, rest} = expr(tokens, 0)

    case rest do
      [:comma | more] -> args(more, [e | acc])
      [:rparen | more] -> {Enum.reverse([e | acc]), more}
      _ -> {Enum.reverse([e | acc]), rest}
    end
  end
end
