defmodule Model.Document do
  alias Model.Cell

  defstruct title: "", cells: []

  def from_lines(title, lines) do
    %__MODULE__{title: title, cells: Enum.map(lines, &%Cell{content: &1})}
  end

  def rows(%__MODULE__{cells: cells}), do: Enum.map(cells, &Cell.text/1)
end
