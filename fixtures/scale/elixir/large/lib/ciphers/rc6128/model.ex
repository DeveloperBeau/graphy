defmodule Ciphers.Rc6128.Model do
  def key_bits, do: 128

  def block_bits, do: 128

  def name, do: "rc6-128"

  def rounds, do: 12
end
