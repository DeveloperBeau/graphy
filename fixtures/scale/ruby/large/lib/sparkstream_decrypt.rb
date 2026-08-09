require_relative 'sparkstream_encrypt'

def sparkstream_decrypt(text, key)
  sparkstream_encrypt(text, key)
end
