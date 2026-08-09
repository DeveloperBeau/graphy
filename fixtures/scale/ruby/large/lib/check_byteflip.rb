require_relative 'byteflip_encode'
require_relative 'byteflip_decode'
require_relative 'corpus_codec'

def check_byteflip
  corpus_codec.each do |text|
    packed = byteflip_encode(text)
    return false if byteflip_decode(packed) != text
  end
  true
end
