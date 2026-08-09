require_relative 'keypad_encrypt'
require_relative 'clamp_shift'

def keypad_decrypt(text, key)
  shift = (key + 10) % 256
  keypad_encrypt(text, -shift)
end
