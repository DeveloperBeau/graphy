local bytes = require("util.bytes")

local function orbitstream_encrypt(text, key)
  local x = (key * 7 + 45) % 256
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do
    x = (13 * x + 45) % 256
    codes[i] = c ~ x
  end
  return bytes.from_codes(codes)
end

local function orbitstream_decrypt(text, key)
  return orbitstream_encrypt(text, key)
end

return { orbitstream_encrypt = orbitstream_encrypt, orbitstream_decrypt = orbitstream_decrypt }
