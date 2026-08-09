local weavecode = require("ciphers.weavecode")
local weavecode_spec = require("specs.weavecode_spec")
local corpus_codec = require("corpus.corpus_codec")

local function check_weavecode()
  local spec = weavecode_spec.get()
  for _, text in ipairs(corpus_codec.corpus_codec()) do
    local packed = weavecode.weavecode_encode(text)
    if weavecode.weavecode_decode(packed) ~= text then return false end
  end
  return spec.category == "codec"
end

return { check_weavecode = check_weavecode }
