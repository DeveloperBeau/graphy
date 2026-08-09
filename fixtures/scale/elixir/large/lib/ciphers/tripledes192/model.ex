defmodule Ciphers.Tripledes192.Model do
  def key_bits, do: 192

  def block_bits, do: 64

  def name, do: "tripledes-192"

  def rounds, do: 16
end
