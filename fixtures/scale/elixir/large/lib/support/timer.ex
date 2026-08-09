defmodule Support.Timer do
  def start, do: System.monotonic_time(:microsecond)

  def measure(started), do: System.monotonic_time(:microsecond) - started

  def millis(span), do: span / 1000
end
