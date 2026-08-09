defmodule Functions.Sqrt do
  def apply([x | _]), do: :math.sqrt(x)
  def apply(_args), do: 0.0

  def arity, do: 1

  def symbol, do: "sqrt"
end
