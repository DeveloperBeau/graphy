defmodule Ciphers.Speck128.Model do
  def key_bits, do: 128

  def block_bits, do: 64

  def name, do: "speck-128"

  def rounds, do: 12
end
