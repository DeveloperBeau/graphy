defmodule Functions.Round do
  def apply([x | _]), do: Float.round(x * 1.0)
  def apply(_args), do: 0.0

  def arity, do: 1

  def symbol, do: "round"
end
