require_relative 'to_codes'

def pearsonhash_digest(text)
  h = 65599
  to_codes(text).each { |c| h = (h * 65599 ^ c) % 4_294_967_296 }
  format('%08x', h)
end
