defmodule Io.Console do
  def banner, do: "calc - type an expression"

  def format_number(n), do: :erlang.float_to_binary(n * 1.0, decimals: 3)

  def print_result(src, n), do: IO.puts(src <> " = " <> format_number(n))
end
