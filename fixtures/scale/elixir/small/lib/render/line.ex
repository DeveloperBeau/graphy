defmodule Render.Line do
  alias Style.Border

  def rule(style, w), do: String.duplicate(Border.horizontal(style), w)

  def framed(style, w, s) do
    v = Border.vertical(style)
    v <> String.pad_trailing(String.slice(s, 0, w), w) <> v
  end
end
