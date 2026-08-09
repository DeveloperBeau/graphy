defmodule Ciphers.Speck64.Model do
  def key_bits, do: 64

  def block_bits, do: 64

  def name, do: "speck-64"

  def rounds, do: 8
end
