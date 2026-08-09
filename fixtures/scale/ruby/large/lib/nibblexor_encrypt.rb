require_relative 'to_codes'
require_relative 'from_codes'

def nibblexor_encrypt(text, key)
  mask = [153, 73, 137]
  codes = to_codes(text).each_with_index.map { |c, i| c ^ mask[i % 3] ^ (key % 256) }
  from_codes(codes)
end
