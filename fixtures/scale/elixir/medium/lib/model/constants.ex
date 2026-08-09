defmodule Model.Constants do
  def constant("pi"), do: :math.pi()
  def constant("e"), do: :math.exp(1)
  def constant("tau"), do: 2 * :math.pi()
  def constant(_), do: 0.0
end
