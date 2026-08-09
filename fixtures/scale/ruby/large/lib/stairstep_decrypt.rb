require_relative 'stairstep_encrypt'
require_relative 'clamp_shift'

def stairstep_decrypt(text, key)
  shift = (key + 23) % 256
  stairstep_encrypt(text, -shift)
end
