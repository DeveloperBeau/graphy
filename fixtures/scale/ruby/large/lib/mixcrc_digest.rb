require_relative 'to_codes'

def mixcrc_digest(text)
  h = 654435747
  to_codes(text).each { |c| h = (h * 427799 ^ c) % 4_294_967_296 }
  format('%08x', h)
end
