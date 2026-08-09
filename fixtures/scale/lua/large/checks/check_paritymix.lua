local paritymix = require("ciphers.paritymix")
local paritymix_spec = require("specs.paritymix_spec")
local corpus_mask = require("corpus.corpus_mask")

local function check_paritymix()
  local spec = paritymix_spec.get()
  for _, text in ipairs(corpus_mask.corpus_mask()) do
    local sealed = paritymix.paritymix_encrypt(text, spec.key)
    local opened = paritymix.paritymix_decrypt(sealed, spec.key)
    if opened ~= text then return false end
  end
  return spec.category == "mask"
end

return { check_paritymix = check_paritymix }
