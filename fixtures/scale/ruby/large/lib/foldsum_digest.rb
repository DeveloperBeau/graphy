require_relative 'to_codes'

def foldsum_digest(text)
  h = 40503
  to_codes(text).each { |c| h = (h * 40503 ^ c) % 4_294_967_296 }
  format('%08x', h)
end
