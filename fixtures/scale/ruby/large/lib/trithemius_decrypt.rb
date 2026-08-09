require_relative 'trithemius_encrypt'
require_relative 'clamp_shift'

def trithemius_decrypt(text, key)
  shift = (key + 13) % 256
  trithemius_encrypt(text, -shift)
end
