defmodule Functions.Hypot do
  def apply([x, y | _]), do: :math.sqrt(x * x + y * y)
  def apply(_args), do: 0.0

  def arity, do: 2

  def symbol, do: "hypot"
end
