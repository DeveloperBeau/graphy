local bytes = require("util.bytes")

local function skewmap_encrypt(text, key)
  local offset = (146 + key) % 256
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do codes[i] = (9 * c + offset) % 256 end
  return bytes.from_codes(codes)
end

local function skewmap_decrypt(text, key)
  local offset = (146 + key) % 256
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do codes[i] = (57 * (c - offset)) % 256 end
  return bytes.from_codes(codes)
end

return { skewmap_encrypt = skewmap_encrypt, skewmap_decrypt = skewmap_decrypt }
