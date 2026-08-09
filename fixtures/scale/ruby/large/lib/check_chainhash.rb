require_relative 'chainhash_digest'
require_relative 'chainhash_digest_pair'
require_relative 'corpus_hash'

def check_chainhash
  corpus_hash.each do |text|
    first = chainhash_digest(text)
    second = chainhash_digest(text)
    return false if first != second || first.length != 8
  end
  true
end
