local staticpad = require("ciphers.staticpad")
local staticpad_spec = require("specs.staticpad_spec")
local corpus_mask = require("corpus.corpus_mask")

local function check_staticpad()
  local spec = staticpad_spec.get()
  for _, text in ipairs(corpus_mask.corpus_mask()) do
    local sealed = staticpad.staticpad_encrypt(text, spec.key)
    local opened = staticpad.staticpad_decrypt(sealed, spec.key)
    if opened ~= text then return false end
  end
  return spec.category == "mask"
end

return { check_staticpad = check_staticpad }
