require_relative 'dualmask_encrypt'

def dualmask_decrypt(text, key)
  dualmask_encrypt(text, key)
end
