defmodule Ciphers.Des64.Model do
  def key_bits, do: 64

  def block_bits, do: 64

  def name, do: "des-64"

  def rounds, do: 8
end
