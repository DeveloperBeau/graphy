defmodule Functions.Ln do
  def apply([x | _]), do: :math.log(x)
  def apply(_args), do: 0.0

  def arity, do: 1

  def symbol, do: "ln"
end
