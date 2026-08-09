require_relative 'to_codes'
require_relative 'from_codes'

def sparkstream_encrypt(text, key)
  x = (key * 7 + 138) % 256
  out = to_codes(text).map do |c|
    x = (25 * x + 138) % 256
    c ^ x
  end
  from_codes(out)
end
