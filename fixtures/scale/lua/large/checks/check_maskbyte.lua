local maskbyte = require("ciphers.maskbyte")
local maskbyte_spec = require("specs.maskbyte_spec")
local corpus_mask = require("corpus.corpus_mask")

local function check_maskbyte()
  local spec = maskbyte_spec.get()
  for _, text in ipairs(corpus_mask.corpus_mask()) do
    local sealed = maskbyte.maskbyte_encrypt(text, spec.key)
    local opened = maskbyte.maskbyte_decrypt(sealed, spec.key)
    if opened ~= text then return false end
  end
  return spec.category == "mask"
end

return { check_maskbyte = check_maskbyte }
