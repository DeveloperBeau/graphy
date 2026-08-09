require_relative 'to_codes'

def sdbmhash_digest(text)
  h = 166136247
  to_codes(text).each { |c| h = (h * 777571 ^ c) % 4_294_967_296 }
  format('%08x', h)
end
