defmodule Functions.Tan do
  def apply([x | _]), do: :math.tan(x)
  def apply(_args), do: 0.0

  def arity, do: 1

  def symbol, do: "tan"
end
