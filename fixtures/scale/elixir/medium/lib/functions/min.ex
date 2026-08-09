defmodule Functions.Min do
  def apply([x, y | _]), do: min(x, y)
  def apply(_args), do: 0.0

  def arity, do: 2

  def symbol, do: "min"
end
