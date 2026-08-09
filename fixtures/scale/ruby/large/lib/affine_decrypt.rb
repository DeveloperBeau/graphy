require_relative 'affine_encrypt'
require_relative 'to_codes'
require_relative 'from_codes'

def affine_decrypt(text, key)
  offset = (91 + key) % 256
  from_codes(to_codes(text).map { |c| (41 * (c - offset)) % 256 })
end
