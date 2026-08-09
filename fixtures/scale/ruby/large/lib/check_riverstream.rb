require_relative 'riverstream_encrypt'
require_relative 'riverstream_decrypt'
require_relative 'corpus_stream'

def check_riverstream
  corpus_stream.each do |text|
    sealed = riverstream_encrypt(text, 14)
    opened = riverstream_decrypt(sealed, 14)
    return false if opened != text
  end
  true
end
