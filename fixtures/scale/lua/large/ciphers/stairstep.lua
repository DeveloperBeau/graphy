local bytes = require("util.bytes")

local function stairstep_encrypt(text, key)
  local shift = (key + 23) % 256
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do codes[i] = c + shift end
  return bytes.from_codes(codes)
end

local function stairstep_decrypt(text, key)
  local shift = (key + 23) % 256
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do codes[i] = c - shift end
  return bytes.from_codes(codes)
end

return { stairstep_encrypt = stairstep_encrypt, stairstep_decrypt = stairstep_decrypt }
