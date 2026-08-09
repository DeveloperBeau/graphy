require_relative 'emberstream_encrypt'

def emberstream_decrypt(text, key)
  emberstream_encrypt(text, key)
end
