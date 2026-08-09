require_relative 'mirrorpack_encode'
require_relative 'mirrorpack_decode'
require_relative 'corpus_codec'

def check_mirrorpack
  corpus_codec.each do |text|
    packed = mirrorpack_encode(text)
    return false if mirrorpack_decode(packed) != text
  end
  true
end
