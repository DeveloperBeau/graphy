defmodule Functions.Neg do
  def apply([x | _]), do: -x
  def apply(_args), do: 0.0

  def arity, do: 1

  def symbol, do: "neg"
end
