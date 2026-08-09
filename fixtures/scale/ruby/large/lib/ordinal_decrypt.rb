require_relative 'ordinal_encrypt'
require_relative 'clamp_shift'

def ordinal_decrypt(text, key)
  shift = (key + 15) % 256
  ordinal_encrypt(text, -shift)
end
