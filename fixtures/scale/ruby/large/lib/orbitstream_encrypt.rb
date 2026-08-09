require_relative 'to_codes'
require_relative 'from_codes'

def orbitstream_encrypt(text, key)
  x = (key * 7 + 45) % 256
  out = to_codes(text).map do |c|
    x = (13 * x + 45) % 256
    c ^ x
  end
  from_codes(out)
end
