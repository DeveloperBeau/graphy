defmodule Ciphers.Present80.Model do
  def key_bits, do: 80

  def block_bits, do: 64

  def name, do: "present-80"

  def rounds, do: 9
end
