local jenkinshash = require("ciphers.jenkinshash")
local jenkinshash_spec = require("specs.jenkinshash_spec")
local corpus_hash = require("corpus.corpus_hash")

local function check_jenkinshash()
  local spec = jenkinshash_spec.get()
  for _, text in ipairs(corpus_hash.corpus_hash()) do
    local first = jenkinshash.jenkinshash_digest(text)
    local second = jenkinshash.jenkinshash_digest(text)
    if first ~= second or #first ~= 8 then return false end
  end
  return spec.category == "hash"
end

return { check_jenkinshash = check_jenkinshash }
