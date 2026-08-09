defmodule Style.Border do
  def horizontal(:heavy), do: "="
  def horizontal(_style), do: "-"

  def vertical(_style), do: "|"
end
