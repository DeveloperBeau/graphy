require_relative 'augustus_encrypt'
require_relative 'clamp_shift'

def augustus_decrypt(text, key)
  shift = (key + 5) % 256
  augustus_encrypt(text, -shift)
end
