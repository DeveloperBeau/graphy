defmodule Ciphers.Threefish512.Model do
  def key_bits, do: 512

  def block_bits, do: 256

  def name, do: "threefish-512"

  def rounds, do: 36
end
