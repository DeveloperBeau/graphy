local cascadestream = require("ciphers.cascadestream")
local cascadestream_spec = require("specs.cascadestream_spec")
local corpus_stream = require("corpus.corpus_stream")

local function check_cascadestream()
  local spec = cascadestream_spec.get()
  for _, text in ipairs(corpus_stream.corpus_stream()) do
    local sealed = cascadestream.cascadestream_encrypt(text, spec.key)
    local opened = cascadestream.cascadestream_decrypt(sealed, spec.key)
    if opened ~= text then return false end
  end
  return spec.category == "stream"
end

return { check_cascadestream = check_cascadestream }
