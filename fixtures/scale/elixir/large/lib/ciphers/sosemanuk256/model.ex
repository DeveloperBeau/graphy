defmodule Ciphers.Sosemanuk256.Model do
  def key_bits, do: 256

  def block_bits, do: 0

  def name, do: "sosemanuk-256"

  def rounds, do: 20
end
