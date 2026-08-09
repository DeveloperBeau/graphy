require_relative 'lcgstream_encrypt'

def lcgstream_decrypt(text, key)
  lcgstream_encrypt(text, key)
end
