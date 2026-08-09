require_relative 'foldsum_digest'
require_relative 'foldsum_digest_pair'
require_relative 'corpus_hash'

def check_foldsum
  corpus_hash.each do |text|
    first = foldsum_digest(text)
    second = foldsum_digest(text)
    return false if first != second || first.length != 8
  end
  true
end
