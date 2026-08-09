require_relative 'to_codes'
require_relative 'from_codes'

def dualmask_encrypt(text, key)
  mask = [146, 44, 84]
  codes = to_codes(text).each_with_index.map { |c, i| c ^ mask[i % 3] ^ (key % 256) }
  from_codes(codes)
end
