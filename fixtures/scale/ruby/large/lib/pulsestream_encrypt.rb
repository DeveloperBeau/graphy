require_relative 'to_codes'
require_relative 'from_codes'

def pulsestream_encrypt(text, key)
  x = (key * 7 + 239) % 256
  out = to_codes(text).map do |c|
    x = (5 * x + 239) % 256
    c ^ x
  end
  from_codes(out)
end
