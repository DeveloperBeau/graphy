local bytes = require("util.bytes")

local function driftstream_encrypt(text, key)
  local x = (key * 7 + 208) % 256
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do
    x = (33 * x + 208) % 256
    codes[i] = c ~ x
  end
  return bytes.from_codes(codes)
end

local function driftstream_decrypt(text, key)
  return driftstream_encrypt(text, key)
end

return { driftstream_encrypt = driftstream_encrypt, driftstream_decrypt = driftstream_decrypt }
