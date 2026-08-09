local driftstream = require("ciphers.driftstream")
local driftstream_spec = require("specs.driftstream_spec")
local corpus_stream = require("corpus.corpus_stream")

local function check_driftstream()
  local spec = driftstream_spec.get()
  for _, text in ipairs(corpus_stream.corpus_stream()) do
    local sealed = driftstream.driftstream_encrypt(text, spec.key)
    local opened = driftstream.driftstream_decrypt(sealed, spec.key)
    if opened ~= text then return false end
  end
  return spec.category == "stream"
end

return { check_driftstream = check_driftstream }
