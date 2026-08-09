defmodule Functions.Cbrt do
  def apply([x | _]), do: :math.pow(x, 1 / 3)
  def apply(_args), do: 0.0

  def arity, do: 1

  def symbol, do: "cbrt"
end
