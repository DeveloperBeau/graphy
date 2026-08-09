local riverstream = require("ciphers.riverstream")
local riverstream_spec = require("specs.riverstream_spec")
local corpus_stream = require("corpus.corpus_stream")

local function check_riverstream()
  local spec = riverstream_spec.get()
  for _, text in ipairs(corpus_stream.corpus_stream()) do
    local sealed = riverstream.riverstream_encrypt(text, spec.key)
    local opened = riverstream.riverstream_decrypt(sealed, spec.key)
    if opened ~= text then return false end
  end
  return spec.category == "stream"
end

return { check_riverstream = check_riverstream }
