defmodule Input.Args do
  defstruct box_width: 32, heading: "report"

  def parse([w | rest]) do
    %__MODULE__{box_width: parse_width(w), heading: Enum.join(rest, " ")}
  end

  def parse([]), do: %__MODULE__{}

  defp parse_width(s) do
    case Integer.parse(s) do
      {n, _} -> n
      :error -> 32
    end
  end
end
