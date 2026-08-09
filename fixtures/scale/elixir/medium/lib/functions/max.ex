defmodule Functions.Max do
  def apply([x, y | _]), do: max(x, y)
  def apply(_args), do: 0.0

  def arity, do: 2

  def symbol, do: "max"
end
