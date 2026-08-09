defmodule Ciphers.Des64.Impl do
  alias Ciphers.Des64.Model

  def encrypt(key, bytes) do
    Enum.map(bytes, &rem(&1 + key + Model.rounds() + Model.key_bits(), 256))
  end

  def decrypt(key, bytes) do
    Enum.map(bytes, &rem(&1 - key - Model.rounds() - Model.key_bits() + 512, 256))
  end
end
