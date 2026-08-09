defmodule Parser.Precedence do
  def level("+"), do: 1
  def level("-"), do: 1
  def level("*"), do: 2
  def level("/"), do: 2
  def level("^"), do: 3
  def level(_op), do: 0
end
