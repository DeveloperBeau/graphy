require_relative 'pearsonhash_digest'
require_relative 'pearsonhash_digest_pair'
require_relative 'corpus_hash'

def check_pearsonhash
  corpus_hash.each do |text|
    first = pearsonhash_digest(text)
    second = pearsonhash_digest(text)
    return false if first != second || first.length != 8
  end
  true
end
