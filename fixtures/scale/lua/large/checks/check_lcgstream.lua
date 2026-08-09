local lcgstream = require("ciphers.lcgstream")
local lcgstream_spec = require("specs.lcgstream_spec")
local corpus_stream = require("corpus.corpus_stream")

local function check_lcgstream()
  local spec = lcgstream_spec.get()
  for _, text in ipairs(corpus_stream.corpus_stream()) do
    local sealed = lcgstream.lcgstream_encrypt(text, spec.key)
    local opened = lcgstream.lcgstream_decrypt(sealed, spec.key)
    if opened ~= text then return false end
  end
  return spec.category == "stream"
end

return { check_lcgstream = check_lcgstream }
