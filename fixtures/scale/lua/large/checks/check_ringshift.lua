local ringshift = require("ciphers.ringshift")
local ringshift_spec = require("specs.ringshift_spec")
local corpus_rotate = require("corpus.corpus_rotate")

local function check_ringshift()
  local spec = ringshift_spec.get()
  for _, text in ipairs(corpus_rotate.corpus_rotate()) do
    local sealed = ringshift.ringshift_encrypt(text, spec.key)
    local opened = ringshift.ringshift_decrypt(sealed, spec.key)
    if opened ~= text then return false end
  end
  return spec.category == "rotate"
end

return { check_ringshift = check_ringshift }
