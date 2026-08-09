local decimation = require("ciphers.decimation")
local decimation_spec = require("specs.decimation_spec")
local corpus_affine = require("corpus.corpus_affine")

local function check_decimation()
  local spec = decimation_spec.get()
  for _, text in ipairs(corpus_affine.corpus_affine()) do
    local sealed = decimation.decimation_encrypt(text, spec.key)
    local opened = decimation.decimation_decrypt(sealed, spec.key)
    if opened ~= text then return false end
  end
  return spec.category == "affine"
end

return { check_decimation = check_decimation }
