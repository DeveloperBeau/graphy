defmodule Functions.Sin do
  def apply([x | _]), do: :math.sin(x)
  def apply(_args), do: 0.0

  def arity, do: 1

  def symbol, do: "sin"
end
