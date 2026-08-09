local dualmask = require("ciphers.dualmask")
local dualmask_spec = require("specs.dualmask_spec")
local corpus_mask = require("corpus.corpus_mask")

local function check_dualmask()
  local spec = dualmask_spec.get()
  for _, text in ipairs(corpus_mask.corpus_mask()) do
    local sealed = dualmask.dualmask_encrypt(text, spec.key)
    local opened = dualmask.dualmask_decrypt(sealed, spec.key)
    if opened ~= text then return false end
  end
  return spec.category == "mask"
end

return { check_dualmask = check_dualmask }
