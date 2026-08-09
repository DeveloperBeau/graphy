defmodule Model.Error do
  def message({:unknown_sym, n}), do: "unknown symbol " <> n

  def message({:arity, n, k}) do
    n <> " expects " <> Integer.to_string(k) <> " args"
  end
end
