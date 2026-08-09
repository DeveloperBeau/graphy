require_relative 'to_codes'

def weavehash_digest(text)
  h = 8191
  to_codes(text).each { |c| h = (h * 37 ^ c) % 4_294_967_296 }
  format('%08x', h)
end
