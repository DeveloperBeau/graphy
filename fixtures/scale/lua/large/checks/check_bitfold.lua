local bitfold = require("ciphers.bitfold")
local bitfold_spec = require("specs.bitfold_spec")
local corpus_mask = require("corpus.corpus_mask")

local function check_bitfold()
  local spec = bitfold_spec.get()
  for _, text in ipairs(corpus_mask.corpus_mask()) do
    local sealed = bitfold.bitfold_encrypt(text, spec.key)
    local opened = bitfold.bitfold_decrypt(sealed, spec.key)
    if opened ~= text then return false end
  end
  return spec.category == "mask"
end

return { check_bitfold = check_bitfold }
