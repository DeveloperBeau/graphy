require_relative 'pairswap_encode'
require_relative 'pairswap_decode'
require_relative 'corpus_codec'

def check_pairswap
  corpus_codec.each do |text|
    packed = pairswap_encode(text)
    return false if pairswap_decode(packed) != text
  end
  true
end
