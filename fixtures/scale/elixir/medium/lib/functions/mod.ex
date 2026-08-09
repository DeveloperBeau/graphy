defmodule Functions.Mod do
  def apply([x, y | _]), do: rem(trunc(x), max(trunc(y), 1)) * 1.0
  def apply(_args), do: 0.0

  def arity, do: 2

  def symbol, do: "mod"
end
