local bytes = require("util.bytes")

local function fnvhash_digest(text)
  local h = 524287
  for _, v in ipairs(bytes.to_codes(text)) do
    h = (h * 41) ~ v
    h = h % 4294967296
  end
  return string.format("%08x", h)
end

local function fnvhash_digest_pair(text)
  return fnvhash_digest(text), #text
end

return { fnvhash_digest = fnvhash_digest, fnvhash_digest_pair = fnvhash_digest_pair }
