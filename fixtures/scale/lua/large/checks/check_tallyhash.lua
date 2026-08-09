local tallyhash = require("ciphers.tallyhash")
local tallyhash_spec = require("specs.tallyhash_spec")
local corpus_hash = require("corpus.corpus_hash")

local function check_tallyhash()
  local spec = tallyhash_spec.get()
  for _, text in ipairs(corpus_hash.corpus_hash()) do
    local first = tallyhash.tallyhash_digest(text)
    local second = tallyhash.tallyhash_digest(text)
    if first ~= second or #first ~= 8 then return false end
  end
  return spec.category == "hash"
end

return { check_tallyhash = check_tallyhash }
