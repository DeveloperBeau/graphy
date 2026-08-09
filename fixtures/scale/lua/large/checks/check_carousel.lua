local carousel = require("ciphers.carousel")
local carousel_spec = require("specs.carousel_spec")
local corpus_rotate = require("corpus.corpus_rotate")

local function check_carousel()
  local spec = carousel_spec.get()
  for _, text in ipairs(corpus_rotate.corpus_rotate()) do
    local sealed = carousel.carousel_encrypt(text, spec.key)
    local opened = carousel.carousel_decrypt(sealed, spec.key)
    if opened ~= text then return false end
  end
  return spec.category == "rotate"
end

return { check_carousel = check_carousel }
