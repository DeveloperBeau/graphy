local bytes = require("util.bytes")

local function pulsestream_encrypt(text, key)
  local x = (key * 7 + 239) % 256
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do
    x = (5 * x + 239) % 256
    codes[i] = c ~ x
  end
  return bytes.from_codes(codes)
end

local function pulsestream_decrypt(text, key)
  return pulsestream_encrypt(text, key)
end

return { pulsestream_encrypt = pulsestream_encrypt, pulsestream_decrypt = pulsestream_decrypt }
