require_relative 'to_codes'
require_relative 'from_codes'

def shiftreel_encrypt(text, key)
  shift = (key + 18) % 256
  from_codes(to_codes(text).map { |c| c + shift })
end
