require_relative 'stridecode_encode'
require_relative 'stridecode_decode'
require_relative 'corpus_codec'

def check_stridecode
  corpus_codec.each do |text|
    packed = stridecode_encode(text)
    return false if stridecode_decode(packed) != text
  end
  true
end
