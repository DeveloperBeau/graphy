defmodule Functions.Exp do
  def apply([x | _]), do: :math.exp(x)
  def apply(_args), do: 0.0

  def arity, do: 1

  def symbol, do: "exp"
end
