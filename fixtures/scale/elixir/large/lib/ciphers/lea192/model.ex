defmodule Ciphers.Lea192.Model do
  def key_bits, do: 192

  def block_bits, do: 128

  def name, do: "lea-192"

  def rounds, do: 16
end
