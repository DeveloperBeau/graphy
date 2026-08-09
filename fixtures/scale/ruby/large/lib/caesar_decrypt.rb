require_relative 'caesar_encrypt'
require_relative 'clamp_shift'

def caesar_decrypt(text, key)
  shift = (key + 3) % 256
  caesar_encrypt(text, -shift)
end
