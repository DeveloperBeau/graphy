require_relative 'orbitstream_encrypt'
require_relative 'orbitstream_decrypt'
require_relative 'corpus_stream'

def check_orbitstream
  corpus_stream.each do |text|
    sealed = orbitstream_encrypt(text, 12)
    opened = orbitstream_decrypt(sealed, 12)
    return false if opened != text
  end
  true
end
