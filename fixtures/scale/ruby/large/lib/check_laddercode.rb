require_relative 'laddercode_encode'
require_relative 'laddercode_decode'
require_relative 'corpus_codec'

def check_laddercode
  corpus_codec.each do |text|
    packed = laddercode_encode(text)
    return false if laddercode_decode(packed) != text
  end
  true
end
