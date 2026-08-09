local emberstream = require("ciphers.emberstream")
local emberstream_spec = require("specs.emberstream_spec")
local corpus_stream = require("corpus.corpus_stream")

local function check_emberstream()
  local spec = emberstream_spec.get()
  for _, text in ipairs(corpus_stream.corpus_stream()) do
    local sealed = emberstream.emberstream_encrypt(text, spec.key)
    local opened = emberstream.emberstream_decrypt(sealed, spec.key)
    if opened ~= text then return false end
  end
  return spec.category == "stream"
end

return { check_emberstream = check_emberstream }
