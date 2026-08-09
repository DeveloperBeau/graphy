defmodule Functions.Trunc do
  def apply([x | _]), do: trunc(x) * 1.0
  def apply(_args), do: 0.0

  def arity, do: 1

  def symbol, do: "trunc"
end
