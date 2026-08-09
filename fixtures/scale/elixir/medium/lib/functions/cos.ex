defmodule Functions.Cos do
  def apply([x | _]), do: :math.cos(x)
  def apply(_args), do: 0.0

  def arity, do: 1

  def symbol, do: "cos"
end
