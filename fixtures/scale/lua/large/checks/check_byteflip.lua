local byteflip = require("ciphers.byteflip")
local byteflip_spec = require("specs.byteflip_spec")
local corpus_codec = require("corpus.corpus_codec")

local function check_byteflip()
  local spec = byteflip_spec.get()
  for _, text in ipairs(corpus_codec.corpus_codec()) do
    local packed = byteflip.byteflip_encode(text)
    if byteflip.byteflip_decode(packed) ~= text then return false end
  end
  return spec.category == "codec"
end

return { check_byteflip = check_byteflip }
