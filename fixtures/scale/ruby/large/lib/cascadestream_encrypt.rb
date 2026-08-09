require_relative 'to_codes'
require_relative 'from_codes'

def cascadestream_encrypt(text, key)
  x = (key * 7 + 14) % 256
  out = to_codes(text).map do |c|
    x = (9 * x + 14) % 256
    c ^ x
  end
  from_codes(out)
end
