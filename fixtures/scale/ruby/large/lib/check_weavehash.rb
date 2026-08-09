require_relative 'weavehash_digest'
require_relative 'weavehash_digest_pair'
require_relative 'corpus_hash'

def check_weavehash
  corpus_hash.each do |text|
    first = weavehash_digest(text)
    second = weavehash_digest(text)
    return false if first != second || first.length != 8
  end
  true
end
