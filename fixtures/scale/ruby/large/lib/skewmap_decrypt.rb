require_relative 'skewmap_encrypt'
require_relative 'to_codes'
require_relative 'from_codes'

def skewmap_decrypt(text, key)
  offset = (146 + key) % 256
  from_codes(to_codes(text).map { |c| (57 * (c - offset)) % 256 })
end
