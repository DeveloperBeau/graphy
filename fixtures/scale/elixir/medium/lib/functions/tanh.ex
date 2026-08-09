defmodule Functions.Tanh do
  def apply([x | _]), do: :math.tanh(x)
  def apply(_args), do: 0.0

  def arity, do: 1

  def symbol, do: "tanh"
end
