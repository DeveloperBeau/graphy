require_relative 'to_codes'
require_relative 'from_codes'

def riverstream_encrypt(text, key)
  x = (key * 7 + 107) % 256
  out = to_codes(text).map do |c|
    x = (21 * x + 107) % 256
    c ^ x
  end
  from_codes(out)
end
