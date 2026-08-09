defmodule Support.Base64 do
  @alphabet "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

  def encode(bytes) do
    Enum.map_join(bytes, &String.at(@alphabet, rem(&1, 64)))
  end
end
