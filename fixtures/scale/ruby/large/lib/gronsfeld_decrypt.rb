require_relative 'gronsfeld_encrypt'
require_relative 'clamp_shift'

def gronsfeld_decrypt(text, key)
  shift = (key + 8) % 256
  gronsfeld_encrypt(text, -shift)
end
