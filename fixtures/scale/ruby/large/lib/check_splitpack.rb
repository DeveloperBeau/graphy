require_relative 'splitpack_encode'
require_relative 'splitpack_decode'
require_relative 'corpus_codec'

def check_splitpack
  corpus_codec.each do |text|
    packed = splitpack_encode(text)
    return false if splitpack_decode(packed) != text
  end
  true
end
