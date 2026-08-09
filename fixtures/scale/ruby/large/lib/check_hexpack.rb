require_relative 'hexpack_encode'
require_relative 'hexpack_decode'
require_relative 'corpus_codec'

def check_hexpack
  corpus_codec.each do |text|
    packed = hexpack_encode(text)
    return false if hexpack_decode(packed) != text
  end
  true
end
