defmodule Model.Value do
  def num(n), do: {:num, n}

  def name(s), do: {:name, s}

  def to_number({:num, n}), do: n
  def to_number({:name, _}), do: 0.0
end
