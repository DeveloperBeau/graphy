defmodule Functions.Avg do
  def apply([x, y | _]), do: (x + y) / 2
  def apply(_args), do: 0.0

  def arity, do: 2

  def symbol, do: "avg"
end
