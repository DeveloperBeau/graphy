defmodule Model.Cell do
  defstruct content: "", pad: 2

  def text(%__MODULE__{content: c}), do: c

  def width(%__MODULE__{content: c, pad: p}), do: String.length(c) + p
end
