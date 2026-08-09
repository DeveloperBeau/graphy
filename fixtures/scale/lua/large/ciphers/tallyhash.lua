local bytes = require("util.bytes")

local function tallyhash_digest(text)
  local h = 97
  for _, v in ipairs(bytes.to_codes(text)) do
    h = (h * 31) ~ v
    h = h % 4294967296
  end
  return string.format("%08x", h)
end

local function tallyhash_digest_pair(text)
  return tallyhash_digest(text), #text
end

return { tallyhash_digest = tallyhash_digest, tallyhash_digest_pair = tallyhash_digest_pair }
