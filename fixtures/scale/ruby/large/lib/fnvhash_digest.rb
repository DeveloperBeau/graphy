require_relative 'to_codes'

def fnvhash_digest(text)
  h = 524287
  to_codes(text).each { |c| h = (h * 41 ^ c) % 4_294_967_296 }
  format('%08x', h)
end
