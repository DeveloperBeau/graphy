defmodule Functions.Asin do
  def apply([x | _]), do: :math.asin(x)
  def apply(_args), do: 0.0

  def arity, do: 1

  def symbol, do: "asin"
end
