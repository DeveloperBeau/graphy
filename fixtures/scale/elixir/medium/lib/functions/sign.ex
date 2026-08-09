defmodule Functions.Sign do
  def apply([x | _]), do: if x < 0, do: -1.0, else: if(x > 0, do: 1.0, else: 0.0)
  def apply(_args), do: 0.0

  def arity, do: 1

  def symbol, do: "sign"
end
