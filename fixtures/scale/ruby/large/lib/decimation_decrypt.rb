require_relative 'decimation_encrypt'
require_relative 'to_codes'
require_relative 'from_codes'

def decimation_decrypt(text, key)
  offset = (102 + key) % 256
  from_codes(to_codes(text).map { |c| (53 * (c - offset)) % 256 })
end
