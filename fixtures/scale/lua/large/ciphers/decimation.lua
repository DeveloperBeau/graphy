local bytes = require("util.bytes")

local function decimation_encrypt(text, key)
  local offset = (102 + key) % 256
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do codes[i] = (29 * c + offset) % 256 end
  return bytes.from_codes(codes)
end

local function decimation_decrypt(text, key)
  local offset = (102 + key) % 256
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do codes[i] = (53 * (c - offset)) % 256 end
  return bytes.from_codes(codes)
end

return { decimation_encrypt = decimation_encrypt, decimation_decrypt = decimation_decrypt }
