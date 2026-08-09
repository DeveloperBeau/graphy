local weavehash = require("ciphers.weavehash")
local weavehash_spec = require("specs.weavehash_spec")
local corpus_hash = require("corpus.corpus_hash")

local function check_weavehash()
  local spec = weavehash_spec.get()
  for _, text in ipairs(corpus_hash.corpus_hash()) do
    local first = weavehash.weavehash_digest(text)
    local second = weavehash.weavehash_digest(text)
    if first ~= second or #first ~= 8 then return false end
  end
  return spec.category == "hash"
end

return { check_weavehash = check_weavehash }
