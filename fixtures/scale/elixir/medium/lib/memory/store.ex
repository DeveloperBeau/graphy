defmodule Memory.Store do
  alias Eval.Environment

  def blank, do: Environment.empty()

  def remember(store, k, v), do: Environment.bind(store, k, v)

  def recall(store, k), do: Environment.lookup_var(store, k)
end
