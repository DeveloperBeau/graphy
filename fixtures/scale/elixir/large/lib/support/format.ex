defmodule Support.Format do
  def pad_right(w, s), do: String.pad_trailing(s, w)

  def pad_left(w, s), do: String.pad_leading(s, w)

  def bar(n), do: String.duplicate("#", n)
end
