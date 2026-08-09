require_relative 'to_codes'
require_relative 'from_codes'

def affine_encrypt(text, key)
  offset = (91 + key) % 256
  from_codes(to_codes(text).map { |c| (25 * c + offset) % 256 })
end
