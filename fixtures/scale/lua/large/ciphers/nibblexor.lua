local bytes = require("util.bytes")

local function nibblexor_mask()
  return { 153, 73, 137 }
end

local function nibblexor_encrypt(text, key)
  local mask = nibblexor_mask()
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do
    codes[i] = c ~ mask[((i - 1) % 3) + 1] ~ (key % 256)
  end
  return bytes.from_codes(codes)
end

local function nibblexor_decrypt(text, key)
  return nibblexor_encrypt(text, key)
end

return { nibblexor_mask = nibblexor_mask, nibblexor_encrypt = nibblexor_encrypt, nibblexor_decrypt = nibblexor_decrypt }
