require_relative 'cascadestream_encrypt'

def cascadestream_decrypt(text, key)
  cascadestream_encrypt(text, key)
end
