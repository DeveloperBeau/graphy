defmodule Functions.Sinh do
  def apply([x | _]), do: :math.sinh(x)
  def apply(_args), do: 0.0

  def arity, do: 1

  def symbol, do: "sinh"
end
