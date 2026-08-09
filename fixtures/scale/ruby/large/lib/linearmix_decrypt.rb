require_relative 'linearmix_encrypt'
require_relative 'to_codes'
require_relative 'from_codes'

def linearmix_decrypt(text, key)
  offset = (135 + key) % 256
  from_codes(to_codes(text).map { |c| (183 * (c - offset)) % 256 })
end
