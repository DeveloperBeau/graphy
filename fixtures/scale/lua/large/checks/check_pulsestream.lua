local pulsestream = require("ciphers.pulsestream")
local pulsestream_spec = require("specs.pulsestream_spec")
local corpus_stream = require("corpus.corpus_stream")

local function check_pulsestream()
  local spec = pulsestream_spec.get()
  for _, text in ipairs(corpus_stream.corpus_stream()) do
    local sealed = pulsestream.pulsestream_encrypt(text, spec.key)
    local opened = pulsestream.pulsestream_decrypt(sealed, spec.key)
    if opened ~= text then return false end
  end
  return spec.category == "stream"
end

return { check_pulsestream = check_pulsestream }
