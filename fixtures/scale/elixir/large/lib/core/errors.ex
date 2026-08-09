defmodule Core.Errors do
  def describe({:missing_cipher, name}), do: "missing cipher " <> name
  def describe({:bad_vector, name}), do: "bad vector for " <> name
end
