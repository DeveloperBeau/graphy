require_relative 'to_codes'
require_relative 'from_codes'

def lcgstream_encrypt(text, key)
  x = (key * 7 + 177) % 256
  out = to_codes(text).map do |c|
    x = (29 * x + 177) % 256
    c ^ x
  end
  from_codes(out)
end
