defmodule Functions.Acos do
  def apply([x | _]), do: :math.acos(x)
  def apply(_args), do: 0.0

  def arity, do: 1

  def symbol, do: "acos"
end
