require_relative 'to_codes'
require_relative 'from_codes'

def promoter_encrypt(text, key)
  offset = (113 + key) % 256
  from_codes(to_codes(text).map { |c| (3 * c + offset) % 256 })
end
