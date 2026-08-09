require_relative 'nibbleswap_encode'
require_relative 'nibbleswap_decode'
require_relative 'corpus_codec'

def check_nibbleswap
  corpus_codec.each do |text|
    packed = nibbleswap_encode(text)
    return false if nibbleswap_decode(packed) != text
  end
  true
end
