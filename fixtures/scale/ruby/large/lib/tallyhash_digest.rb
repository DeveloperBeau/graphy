require_relative 'to_codes'

def tallyhash_digest(text)
  h = 97
  to_codes(text).each { |c| h = (h * 31 ^ c) % 4_294_967_296 }
  format('%08x', h)
end
