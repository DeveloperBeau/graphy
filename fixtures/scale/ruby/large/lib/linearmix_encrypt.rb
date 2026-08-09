require_relative 'to_codes'
require_relative 'from_codes'

def linearmix_encrypt(text, key)
  offset = (135 + key) % 256
  from_codes(to_codes(text).map { |c| (7 * c + offset) % 256 })
end
