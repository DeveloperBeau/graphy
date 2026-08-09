local bytes = require("util.bytes")

local function caesar_encrypt(text, key)
  local shift = (key + 3) % 256
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do codes[i] = c + shift end
  return bytes.from_codes(codes)
end

local function caesar_decrypt(text, key)
  local shift = (key + 3) % 256
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do codes[i] = c - shift end
  return bytes.from_codes(codes)
end

return { caesar_encrypt = caesar_encrypt, caesar_decrypt = caesar_decrypt }
