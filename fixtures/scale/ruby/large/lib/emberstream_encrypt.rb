require_relative 'to_codes'
require_relative 'from_codes'

def emberstream_encrypt(text, key)
  x = (key * 7 + 76) % 256
  out = to_codes(text).map do |c|
    x = (17 * x + 76) % 256
    c ^ x
  end
  from_codes(out)
end
