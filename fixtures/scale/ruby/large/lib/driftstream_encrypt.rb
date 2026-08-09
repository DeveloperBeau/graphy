require_relative 'to_codes'
require_relative 'from_codes'

def driftstream_encrypt(text, key)
  x = (key * 7 + 208) % 256
  out = to_codes(text).map do |c|
    x = (33 * x + 208) % 256
    c ^ x
  end
  from_codes(out)
end
