require_relative 'to_codes'

def djbhash_digest(text)
  h = 131071
  to_codes(text).each { |c| h = (h * 43 ^ c) % 4_294_967_296 }
  format('%08x', h)
end
