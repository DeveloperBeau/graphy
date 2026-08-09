require_relative 'to_codes'

def chainhash_digest(text)
  h = 131
  to_codes(text).each { |c| h = (h * 131 ^ c) % 4_294_967_296 }
  format('%08x', h)
end
