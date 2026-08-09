defmodule Ciphers.Threefish256.Model do
  def key_bits, do: 256

  def block_bits, do: 256

  def name, do: "threefish-256"

  def rounds, do: 20
end
