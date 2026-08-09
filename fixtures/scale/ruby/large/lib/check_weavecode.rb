require_relative 'weavecode_encode'
require_relative 'weavecode_decode'
require_relative 'corpus_codec'

def check_weavecode
  corpus_codec.each do |text|
    packed = weavecode_encode(text)
    return false if weavecode_decode(packed) != text
  end
  true
end
