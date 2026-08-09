defmodule Functions.Abs do
  def apply([x | _]), do: abs(x)
  def apply(_args), do: 0.0

  def arity, do: 1

  def symbol, do: "abs"
end
