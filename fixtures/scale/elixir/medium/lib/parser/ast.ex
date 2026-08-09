defmodule Parser.Ast do
  def lit(n), do: {:lit, n}

  def var(name), do: {:var, name}

  def binop(op, l, r), do: {:binop, op, l, r}

  def call(name, args), do: {:call, name, args}
end
