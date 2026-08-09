local bytes = require("util.bytes")

local function augustus_encrypt(text, key)
  local shift = (key + 5) % 256
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do codes[i] = c + shift end
  return bytes.from_codes(codes)
end

local function augustus_decrypt(text, key)
  local shift = (key + 5) % 256
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do codes[i] = c - shift end
  return bytes.from_codes(codes)
end

return { augustus_encrypt = augustus_encrypt, augustus_decrypt = augustus_decrypt }
