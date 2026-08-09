defmodule Output.Writer do
  alias Render.Box
  alias Style.Palette

  def render(palette, w, doc) do
    Enum.map(Box.draw(:rounded, w, doc), &Palette.pick(palette, &1))
  end

  def emit(lines), do: Enum.each(lines, &IO.puts/1)
end
