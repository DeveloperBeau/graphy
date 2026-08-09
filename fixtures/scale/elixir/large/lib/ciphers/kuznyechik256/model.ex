defmodule Ciphers.Kuznyechik256.Model do
  def key_bits, do: 256

  def block_bits, do: 128

  def name, do: "kuznyechik-256"

  def rounds, do: 20
end
