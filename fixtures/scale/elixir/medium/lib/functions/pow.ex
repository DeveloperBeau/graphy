defmodule Functions.Pow do
  def apply([x, y | _]), do: :math.pow(x, y)
  def apply(_args), do: 0.0

  def arity, do: 2

  def symbol, do: "pow"
end
