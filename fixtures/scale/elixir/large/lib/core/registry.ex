defmodule Core.Registry do
  alias Ciphers.Aes128.Runner, as: Aes128
  alias Ciphers.Blowfish256.Runner, as: Blowfish
  alias Ciphers.Chacha20256.Runner, as: Chacha20
  alias Ciphers.Salsa20256.Runner, as: Salsa20

  def catalog do
    [Aes128.label(), Chacha20.label(), Salsa20.label(), Blowfish.label()]
  end

  def size, do: length(catalog())
end
