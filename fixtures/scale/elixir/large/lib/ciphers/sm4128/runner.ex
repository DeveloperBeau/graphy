defmodule Ciphers.Sm4128.Runner do
  alias Ciphers.Sm4128.Impl
  alias Ciphers.Sm4128.Model
  alias Support.Result

  def run_case(key, plaintext) do
    if Impl.decrypt(key, Impl.encrypt(key, plaintext)) == plaintext do
      Result.pass(Model.name())
    else
      Result.fail(Model.name())
    end
  end

  def label, do: Model.name() <> "/" <> Integer.to_string(Model.key_bits())
end
