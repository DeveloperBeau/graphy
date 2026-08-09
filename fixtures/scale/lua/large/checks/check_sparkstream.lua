local sparkstream = require("ciphers.sparkstream")
local sparkstream_spec = require("specs.sparkstream_spec")
local corpus_stream = require("corpus.corpus_stream")

local function check_sparkstream()
  local spec = sparkstream_spec.get()
  for _, text in ipairs(corpus_stream.corpus_stream()) do
    local sealed = sparkstream.sparkstream_encrypt(text, spec.key)
    local opened = sparkstream.sparkstream_decrypt(sealed, spec.key)
    if opened ~= text then return false end
  end
  return spec.category == "stream"
end

return { check_sparkstream = check_sparkstream }
