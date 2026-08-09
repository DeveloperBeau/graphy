require_relative 'to_codes'
require_relative 'from_codes'

def skewmap_encrypt(text, key)
  offset = (146 + key) % 256
  from_codes(to_codes(text).map { |c| (9 * c + offset) % 256 })
end
