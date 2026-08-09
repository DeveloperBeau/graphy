require_relative 'mixcrc_digest'
require_relative 'mixcrc_digest_pair'
require_relative 'corpus_hash'

def check_mixcrc
  corpus_hash.each do |text|
    first = mixcrc_digest(text)
    second = mixcrc_digest(text)
    return false if first != second || first.length != 8
  end
  true
end
