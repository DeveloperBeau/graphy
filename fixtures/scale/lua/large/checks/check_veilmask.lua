local veilmask = require("ciphers.veilmask")
local veilmask_spec = require("specs.veilmask_spec")
local corpus_mask = require("corpus.corpus_mask")

local function check_veilmask()
  local spec = veilmask_spec.get()
  for _, text in ipairs(corpus_mask.corpus_mask()) do
    local sealed = veilmask.veilmask_encrypt(text, spec.key)
    local opened = veilmask.veilmask_decrypt(sealed, spec.key)
    if opened ~= text then return false end
  end
  return spec.category == "mask"
end

return { check_veilmask = check_veilmask }
