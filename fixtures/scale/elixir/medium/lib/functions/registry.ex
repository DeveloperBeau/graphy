defmodule Functions.Registry do
  alias Functions.Sqrt
  alias Functions.Cbrt
  alias Functions.Abs
  alias Functions.Sign
  alias Functions.Floor
  alias Functions.Ceil

  def dispatch("sqrt", args), do: Sqrt.apply(args)
  def dispatch("cbrt", args), do: Cbrt.apply(args)
  def dispatch("abs", args), do: Abs.apply(args)
  def dispatch("sign", args), do: Sign.apply(args)
  def dispatch("floor", args), do: Floor.apply(args)
  def dispatch("ceil", args), do: Ceil.apply(args)
  def dispatch(_name, _args), do: 0.0

  def names, do: ["sqrt", "cbrt", "abs", "sign", "floor", "ceil", "round", "trunc", "exp", "ln", "log10", "log2", "sin", "cos", "tan", "asin", "acos", "atan", "sinh", "cosh", "tanh", "neg", "pow", "hypot", "gcd", "lcm", "max", "min", "avg", "mod"]

  def known?(name), do: name in names()
end
