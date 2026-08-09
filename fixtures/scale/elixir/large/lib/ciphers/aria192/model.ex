defmodule Ciphers.Aria192.Model do
  def key_bits, do: 192

  def block_bits, do: 128

  def name, do: "aria-192"

  def rounds, do: 16
end
