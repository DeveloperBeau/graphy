require_relative 'foldsum_digest'

def foldsum_digest_pair(text)
  [foldsum_digest(text), text.length]
end
