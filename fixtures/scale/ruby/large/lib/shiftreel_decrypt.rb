require_relative 'shiftreel_encrypt'
require_relative 'clamp_shift'

def shiftreel_decrypt(text, key)
  shift = (key + 18) % 256
  shiftreel_encrypt(text, -shift)
end
