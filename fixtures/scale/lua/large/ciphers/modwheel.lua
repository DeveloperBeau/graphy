local bytes = require("util.bytes")

local function modwheel_encrypt(text, key)
  local offset = (124 + key) % 256
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do codes[i] = (5 * c + offset) % 256 end
  return bytes.from_codes(codes)
end

local function modwheel_decrypt(text, key)
  local offset = (124 + key) % 256
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do codes[i] = (205 * (c - offset)) % 256 end
  return bytes.from_codes(codes)
end

return { modwheel_encrypt = modwheel_encrypt, modwheel_decrypt = modwheel_decrypt }
