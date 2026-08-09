require_relative 'to_codes'
require_relative 'from_codes'

def maskbyte_encrypt(text, key)
  mask = [118, 184, 128]
  codes = to_codes(text).each_with_index.map { |c, i| c ^ mask[i % 3] ^ (key % 256) }
  from_codes(codes)
end
