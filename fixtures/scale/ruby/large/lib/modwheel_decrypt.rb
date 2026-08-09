require_relative 'modwheel_encrypt'
require_relative 'to_codes'
require_relative 'from_codes'

def modwheel_decrypt(text, key)
  offset = (124 + key) % 256
  from_codes(to_codes(text).map { |c| (205 * (c - offset)) % 256 })
end
