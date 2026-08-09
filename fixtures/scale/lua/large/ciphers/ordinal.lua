local bytes = require("util.bytes")

local function ordinal_encrypt(text, key)
  local shift = (key + 15) % 256
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do codes[i] = c + shift end
  return bytes.from_codes(codes)
end

local function ordinal_decrypt(text, key)
  local shift = (key + 15) % 256
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do codes[i] = c - shift end
  return bytes.from_codes(codes)
end

return { ordinal_encrypt = ordinal_encrypt, ordinal_decrypt = ordinal_decrypt }
