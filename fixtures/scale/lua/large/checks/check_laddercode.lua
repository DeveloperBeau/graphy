local laddercode = require("ciphers.laddercode")
local laddercode_spec = require("specs.laddercode_spec")
local corpus_codec = require("corpus.corpus_codec")

local function check_laddercode()
  local spec = laddercode_spec.get()
  for _, text in ipairs(corpus_codec.corpus_codec()) do
    local packed = laddercode.laddercode_encode(text)
    if laddercode.laddercode_decode(packed) ~= text then return false end
  end
  return spec.category == "codec"
end

return { check_laddercode = check_laddercode }
