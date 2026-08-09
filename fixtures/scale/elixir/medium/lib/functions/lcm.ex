defmodule Functions.Lcm do
  def apply([x, y | _]), do: div(trunc(x) * trunc(y), max(Integer.gcd(trunc(x), trunc(y)), 1)) * 1.0
  def apply(_args), do: 0.0

  def arity, do: 2

  def symbol, do: "lcm"
end
