require_relative 'staticpad_encrypt'

def staticpad_decrypt(text, key)
  staticpad_encrypt(text, key)
end
