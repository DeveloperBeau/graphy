defmodule History.Log do
  defstruct entries: []

  def record(%__MODULE__{entries: es} = log, src, val) do
    %{log | entries: [{src, val} | es]}
  end

  def recent(%__MODULE__{entries: es}, n \\ 10), do: Enum.take(es, n)
end
