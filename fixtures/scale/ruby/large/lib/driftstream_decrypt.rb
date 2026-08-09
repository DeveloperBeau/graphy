require_relative 'driftstream_encrypt'

def driftstream_decrypt(text, key)
  driftstream_encrypt(text, key)
end
