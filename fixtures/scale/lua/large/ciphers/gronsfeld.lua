local bytes = require("util.bytes")

local function gronsfeld_encrypt(text, key)
  local shift = (key + 8) % 256
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do codes[i] = c + shift end
  return bytes.from_codes(codes)
end

local function gronsfeld_decrypt(text, key)
  local shift = (key + 8) % 256
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do codes[i] = c - shift end
  return bytes.from_codes(codes)
end

return { gronsfeld_encrypt = gronsfeld_encrypt, gronsfeld_decrypt = gronsfeld_decrypt }
