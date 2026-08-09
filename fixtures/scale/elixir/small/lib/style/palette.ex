defmodule Style.Palette do
  def pick(:plain, s), do: s
  def pick(:bright, s), do: "*" <> s <> "*"
end
