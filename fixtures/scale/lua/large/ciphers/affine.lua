local bytes = require("util.bytes")

local function affine_encrypt(text, key)
  local offset = (91 + key) % 256
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do codes[i] = (25 * c + offset) % 256 end
  return bytes.from_codes(codes)
end

local function affine_decrypt(text, key)
  local offset = (91 + key) % 256
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do codes[i] = (41 * (c - offset)) % 256 end
  return bytes.from_codes(codes)
end

return { affine_encrypt = affine_encrypt, affine_decrypt = affine_decrypt }
