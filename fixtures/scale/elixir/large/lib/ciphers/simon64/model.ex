defmodule Ciphers.Simon64.Model do
  def key_bits, do: 64

  def block_bits, do: 64

  def name, do: "simon-64"

  def rounds, do: 8
end
