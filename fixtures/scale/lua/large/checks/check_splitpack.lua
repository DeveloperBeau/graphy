local splitpack = require("ciphers.splitpack")
local splitpack_spec = require("specs.splitpack_spec")
local corpus_codec = require("corpus.corpus_codec")

local function check_splitpack()
  local spec = splitpack_spec.get()
  for _, text in ipairs(corpus_codec.corpus_codec()) do
    local packed = splitpack.splitpack_encode(text)
    if splitpack.splitpack_decode(packed) ~= text then return false end
  end
  return spec.category == "codec"
end

return { check_splitpack = check_splitpack }
