defmodule Model.Number do
  def from_int(i), do: i * 1.0

  def zero?(x), do: abs(x) < 1.0e-9
end
