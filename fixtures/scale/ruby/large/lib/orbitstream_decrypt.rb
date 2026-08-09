require_relative 'orbitstream_encrypt'

def orbitstream_decrypt(text, key)
  orbitstream_encrypt(text, key)
end
