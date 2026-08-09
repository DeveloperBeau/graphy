defmodule Functions.Atan do
  def apply([x | _]), do: :math.atan(x)
  def apply(_args), do: 0.0

  def arity, do: 1

  def symbol, do: "atan"
end
