require_relative 'riverstream_encrypt'

def riverstream_decrypt(text, key)
  riverstream_encrypt(text, key)
end
