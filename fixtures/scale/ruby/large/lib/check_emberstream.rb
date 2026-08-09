require_relative 'emberstream_encrypt'
require_relative 'emberstream_decrypt'
require_relative 'corpus_stream'

def check_emberstream
  corpus_stream.each do |text|
    sealed = emberstream_encrypt(text, 13)
    opened = emberstream_decrypt(sealed, 13)
    return false if opened != text
  end
  true
end
