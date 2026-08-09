defmodule Ciphers.Hight128.Model do
  def key_bits, do: 128

  def block_bits, do: 64

  def name, do: "hight-128"

  def rounds, do: 12
end
