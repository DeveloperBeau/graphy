defmodule Ciphers.Rc4128.Model do
  def key_bits, do: 128

  def block_bits, do: 0

  def name, do: "rc4-128"

  def rounds, do: 12
end
