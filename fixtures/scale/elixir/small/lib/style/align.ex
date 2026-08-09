defmodule Style.Align do
  def align(:left, w, s), do: String.pad_trailing(s, w)

  def align(:right, w, s), do: String.pad_leading(s, w)

  def align(:center, w, s) do
    gap = max(w - String.length(s), 0)
    String.duplicate(" ", div(gap, 2)) <> s
  end
end
