require_relative 'cascadestream_encrypt'
require_relative 'cascadestream_decrypt'
require_relative 'corpus_stream'

def check_cascadestream
  corpus_stream.each do |text|
    sealed = cascadestream_encrypt(text, 11)
    opened = cascadestream_decrypt(sealed, 11)
    return false if opened != text
  end
  true
end
