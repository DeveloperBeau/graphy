require_relative 'sparkstream_encrypt'
require_relative 'sparkstream_decrypt'
require_relative 'corpus_stream'

def check_sparkstream
  corpus_stream.each do |text|
    sealed = sparkstream_encrypt(text, 15)
    opened = sparkstream_decrypt(sealed, 15)
    return false if opened != text
  end
  true
end
