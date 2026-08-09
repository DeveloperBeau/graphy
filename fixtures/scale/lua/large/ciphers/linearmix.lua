local bytes = require("util.bytes")

local function linearmix_encrypt(text, key)
  local offset = (135 + key) % 256
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do codes[i] = (7 * c + offset) % 256 end
  return bytes.from_codes(codes)
end

local function linearmix_decrypt(text, key)
  local offset = (135 + key) % 256
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do codes[i] = (183 * (c - offset)) % 256 end
  return bytes.from_codes(codes)
end

return { linearmix_encrypt = linearmix_encrypt, linearmix_decrypt = linearmix_decrypt }
