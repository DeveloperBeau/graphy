local bytes = require("util.bytes")

local function trithemius_encrypt(text, key)
  local shift = (key + 13) % 256
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do codes[i] = c + shift end
  return bytes.from_codes(codes)
end

local function trithemius_decrypt(text, key)
  local shift = (key + 13) % 256
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do codes[i] = c - shift end
  return bytes.from_codes(codes)
end

return { trithemius_encrypt = trithemius_encrypt, trithemius_decrypt = trithemius_decrypt }
