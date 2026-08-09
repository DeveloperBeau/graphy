require_relative 'promoter_encrypt'
require_relative 'to_codes'
require_relative 'from_codes'

def promoter_decrypt(text, key)
  offset = (113 + key) % 256
  from_codes(to_codes(text).map { |c| (171 * (c - offset)) % 256 })
end
