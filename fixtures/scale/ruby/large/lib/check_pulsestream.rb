require_relative 'pulsestream_encrypt'
require_relative 'pulsestream_decrypt'
require_relative 'corpus_stream'

def check_pulsestream
  corpus_stream.each do |text|
    sealed = pulsestream_encrypt(text, 10)
    opened = pulsestream_decrypt(sealed, 10)
    return false if opened != text
  end
  true
end
