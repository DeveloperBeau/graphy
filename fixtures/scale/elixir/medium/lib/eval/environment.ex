defmodule Eval.Environment do
  alias Model.Constants

  def empty, do: %{}

  def bind(env, k, v), do: Map.put(env, k, v)

  def lookup_var(env, k), do: Map.get(env, k, Constants.constant(k))
end
