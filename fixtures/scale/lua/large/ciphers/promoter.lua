local bytes = require("util.bytes")

local function promoter_encrypt(text, key)
  local offset = (113 + key) % 256
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do codes[i] = (3 * c + offset) % 256 end
  return bytes.from_codes(codes)
end

local function promoter_decrypt(text, key)
  local offset = (113 + key) % 256
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do codes[i] = (171 * (c - offset)) % 256 end
  return bytes.from_codes(codes)
end

return { promoter_encrypt = promoter_encrypt, promoter_decrypt = promoter_decrypt }
