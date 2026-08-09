local bytes = require("util.bytes")

local function keypad_encrypt(text, key)
  local shift = (key + 10) % 256
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do codes[i] = c + shift end
  return bytes.from_codes(codes)
end

local function keypad_decrypt(text, key)
  local shift = (key + 10) % 256
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do codes[i] = c - shift end
  return bytes.from_codes(codes)
end

return { keypad_encrypt = keypad_encrypt, keypad_decrypt = keypad_decrypt }
