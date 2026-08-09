defmodule Ciphers.Gost256.Model do
  def key_bits, do: 256

  def block_bits, do: 64

  def name, do: "gost-256"

  def rounds, do: 20
end
