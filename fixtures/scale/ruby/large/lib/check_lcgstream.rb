require_relative 'lcgstream_encrypt'
require_relative 'lcgstream_decrypt'
require_relative 'corpus_stream'

def check_lcgstream
  corpus_stream.each do |text|
    sealed = lcgstream_encrypt(text, 8)
    opened = lcgstream_decrypt(sealed, 8)
    return false if opened != text
  end
  true
end
