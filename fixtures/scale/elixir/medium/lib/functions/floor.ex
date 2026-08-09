defmodule Functions.Floor do
  def apply([x | _]), do: Float.floor(x * 1.0)
  def apply(_args), do: 0.0

  def arity, do: 1

  def symbol, do: "floor"
end
