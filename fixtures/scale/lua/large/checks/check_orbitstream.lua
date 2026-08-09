local orbitstream = require("ciphers.orbitstream")
local orbitstream_spec = require("specs.orbitstream_spec")
local corpus_stream = require("corpus.corpus_stream")

local function check_orbitstream()
  local spec = orbitstream_spec.get()
  for _, text in ipairs(corpus_stream.corpus_stream()) do
    local sealed = orbitstream.orbitstream_encrypt(text, spec.key)
    local opened = orbitstream.orbitstream_decrypt(sealed, spec.key)
    if opened ~= text then return false end
  end
  return spec.category == "stream"
end

return { check_orbitstream = check_orbitstream }
