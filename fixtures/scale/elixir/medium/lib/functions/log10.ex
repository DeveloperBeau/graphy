defmodule Functions.Log10 do
  def apply([x | _]), do: :math.log10(x)
  def apply(_args), do: 0.0

  def arity, do: 1

  def symbol, do: "log10"
end
