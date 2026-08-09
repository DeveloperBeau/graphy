require_relative 'tallyhash_digest'

def tallyhash_digest_pair(text)
  [tallyhash_digest(text), text.length]
end
