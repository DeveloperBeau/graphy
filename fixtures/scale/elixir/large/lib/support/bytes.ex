defmodule Support.Bytes do
  def zeros(n), do: List.duplicate(0, n)

  def add_all(k, bytes), do: Enum.map(bytes, &rem(&1 + k, 256))

  def rotate(n, bytes), do: Enum.drop(bytes, n) ++ Enum.take(bytes, n)
end
