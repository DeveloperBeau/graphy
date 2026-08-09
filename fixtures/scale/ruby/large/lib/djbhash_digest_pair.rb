require_relative 'djbhash_digest'

def djbhash_digest_pair(text)
  [djbhash_digest(text), text.length]
end
