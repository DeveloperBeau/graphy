defmodule Functions.Cosh do
  def apply([x | _]), do: :math.cosh(x)
  def apply(_args), do: 0.0

  def arity, do: 1

  def symbol, do: "cosh"
end
