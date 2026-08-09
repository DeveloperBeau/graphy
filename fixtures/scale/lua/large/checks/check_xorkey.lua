local xorkey = require("ciphers.xorkey")
local xorkey_spec = require("specs.xorkey_spec")
local corpus_mask = require("corpus.corpus_mask")

local function check_xorkey()
  local spec = xorkey_spec.get()
  for _, text in ipairs(corpus_mask.corpus_mask()) do
    local sealed = xorkey.xorkey_encrypt(text, spec.key)
    local opened = xorkey.xorkey_decrypt(sealed, spec.key)
    if opened ~= text then return false end
  end
  return spec.category == "mask"
end

return { check_xorkey = check_xorkey }
