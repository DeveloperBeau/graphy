require_relative 'to_codes'

def jenkinshash_digest(text)
  h = 5381
  to_codes(text).each { |c| h = (h * 33 ^ c) % 4_294_967_296 }
  format('%08x', h)
end
