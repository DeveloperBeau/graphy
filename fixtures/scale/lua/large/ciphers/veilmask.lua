local bytes = require("util.bytes")

local function veilmask_mask()
  return { 139, 15, 31 }
end

local function veilmask_encrypt(text, key)
  local mask = veilmask_mask()
  local codes = bytes.to_codes(text)
  for i, c in ipairs(codes) do
    codes[i] = c ~ mask[((i - 1) % 3) + 1] ~ (key % 256)
  end
  return bytes.from_codes(codes)
end

local function veilmask_decrypt(text, key)
  return veilmask_encrypt(text, key)
end

return { veilmask_mask = veilmask_mask, veilmask_encrypt = veilmask_encrypt, veilmask_decrypt = veilmask_decrypt }
