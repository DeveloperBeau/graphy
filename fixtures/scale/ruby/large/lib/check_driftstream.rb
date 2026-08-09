require_relative 'driftstream_encrypt'
require_relative 'driftstream_decrypt'
require_relative 'corpus_stream'

def check_driftstream
  corpus_stream.each do |text|
    sealed = driftstream_encrypt(text, 9)
    opened = driftstream_decrypt(sealed, 9)
    return false if opened != text
  end
  true
end
