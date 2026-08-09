local stridecode = require("ciphers.stridecode")
local stridecode_spec = require("specs.stridecode_spec")
local corpus_codec = require("corpus.corpus_codec")

local function check_stridecode()
  local spec = stridecode_spec.get()
  for _, text in ipairs(corpus_codec.corpus_codec()) do
    local packed = stridecode.stridecode_encode(text)
    if stridecode.stridecode_decode(packed) ~= text then return false end
  end
  return spec.category == "codec"
end

return { check_stridecode = check_stridecode }
