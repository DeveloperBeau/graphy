defmodule Functions.Log2 do
  def apply([x | _]), do: :math.log2(x)
  def apply(_args), do: 0.0

  def arity, do: 1

  def symbol, do: "log2"
end
