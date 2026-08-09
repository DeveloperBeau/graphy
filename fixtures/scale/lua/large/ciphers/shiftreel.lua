local bytes = require("util.bytes")

local function shiftreel_encrypt(text, key)
  local shift = (key + 18) % 256
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do codes[i] = c + shift end
  return bytes.from_codes(codes)
end

local function shiftreel_decrypt(text, key)
  local shift = (key + 18) % 256
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do codes[i] = c - shift end
  return bytes.from_codes(codes)
end

return { shiftreel_encrypt = shiftreel_encrypt, shiftreel_decrypt = shiftreel_decrypt }
