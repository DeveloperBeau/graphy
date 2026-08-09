require_relative 'to_codes'
require_relative 'from_codes'

def stairstep_encrypt(text, key)
  shift = (key + 23) % 256
  from_codes(to_codes(text).map { |c| c + shift })
end
