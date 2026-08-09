local fnvhash = require("ciphers.fnvhash")
local fnvhash_spec = require("specs.fnvhash_spec")
local corpus_hash = require("corpus.corpus_hash")

local function check_fnvhash()
  local spec = fnvhash_spec.get()
  for _, text in ipairs(corpus_hash.corpus_hash()) do
    local first = fnvhash.fnvhash_digest(text)
    local second = fnvhash.fnvhash_digest(text)
    if first ~= second or #first ~= 8 then return false end
  end
  return spec.category == "hash"
end

return { check_fnvhash = check_fnvhash }
