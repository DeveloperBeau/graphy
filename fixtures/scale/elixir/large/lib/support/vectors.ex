defmodule Support.Vectors do
  alias Support.Rng

  defstruct key: 0, plaintext: []

  def sample(key, n), do: %__MODULE__{key: key, plaintext: Rng.stream(n, key + 7)}
end
