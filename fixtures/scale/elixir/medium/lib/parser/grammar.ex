defmodule Parser.Grammar do
  def binary_op?({:op, _}), do: true
  def binary_op?(_token), do: false

  def call_start?({:ident, _}), do: true
  def call_start?(_token), do: false
end
