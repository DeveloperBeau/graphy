require_relative 'chainhash_digest'

def chainhash_digest_pair(text)
  [chainhash_digest(text), text.length]
end
