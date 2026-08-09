local foldsum = require("ciphers.foldsum")
local foldsum_spec = require("specs.foldsum_spec")
local corpus_hash = require("corpus.corpus_hash")

local function check_foldsum()
  local spec = foldsum_spec.get()
  for _, text in ipairs(corpus_hash.corpus_hash()) do
    local first = foldsum.foldsum_digest(text)
    local second = foldsum.foldsum_digest(text)
    if first ~= second or #first ~= 8 then return false end
  end
  return spec.category == "hash"
end

return { check_foldsum = check_foldsum }
