require_relative 'pearsonhash_digest'

def pearsonhash_digest_pair(text)
  [pearsonhash_digest(text), text.length]
end
