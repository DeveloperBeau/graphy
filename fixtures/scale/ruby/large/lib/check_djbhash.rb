require_relative 'djbhash_digest'
require_relative 'djbhash_digest_pair'
require_relative 'corpus_hash'

def check_djbhash
  corpus_hash.each do |text|
    first = djbhash_digest(text)
    second = djbhash_digest(text)
    return false if first != second || first.length != 8
  end
  true
end
