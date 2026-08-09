defmodule Ciphers.Lea128.Model do
  def key_bits, do: 128

  def block_bits, do: 128

  def name, do: "lea-128"

  def rounds, do: 12
end
