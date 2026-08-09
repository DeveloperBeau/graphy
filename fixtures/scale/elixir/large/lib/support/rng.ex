defmodule Support.Rng do
  def next(seed) do
    s = rem(seed * 1_103_515_245 + 12_345, 2_147_483_647)
    {rem(s, 256), s}
  end

  def stream(0, _seed), do: []

  def stream(n, seed) do
    {b, s} = next(seed)
    [b | stream(n - 1, s)]
  end
end
