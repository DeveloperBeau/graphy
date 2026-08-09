local nibblexor = require("ciphers.nibblexor")
local nibblexor_spec = require("specs.nibblexor_spec")
local corpus_mask = require("corpus.corpus_mask")

local function check_nibblexor()
  local spec = nibblexor_spec.get()
  for _, text in ipairs(corpus_mask.corpus_mask()) do
    local sealed = nibblexor.nibblexor_encrypt(text, spec.key)
    local opened = nibblexor.nibblexor_decrypt(sealed, spec.key)
    if opened ~= text then return false end
  end
  return spec.category == "mask"
end

return { check_nibblexor = check_nibblexor }
