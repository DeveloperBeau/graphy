defmodule Support.Hex do
  @digits ~c"0123456789abcdef"

  def encode(bytes) do
    Enum.map_join(bytes, fn b ->
      <<Enum.at(@digits, div(b, 16)), Enum.at(@digits, rem(b, 16))>>
    end)
  end

  def decode(text) do
    text
    |> String.to_charlist()
    |> Enum.chunk_every(2)
    |> Enum.map(fn [h, l] -> val(h) * 16 + val(l) end)
  end

  defp val(c), do: Enum.find_index(@digits, &(&1 == c)) || 0
end
