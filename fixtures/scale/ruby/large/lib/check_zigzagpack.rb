require_relative 'zigzagpack_encode'
require_relative 'zigzagpack_decode'
require_relative 'corpus_codec'

def check_zigzagpack
  corpus_codec.each do |text|
    packed = zigzagpack_encode(text)
    return false if zigzagpack_decode(packed) != text
  end
  true
end
