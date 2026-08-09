local bytes = require("util.bytes")

local function sdbmhash_digest(text)
  local h = 166136247
  for _, v in ipairs(bytes.to_codes(text)) do
    h = (h * 777571) ~ v
    h = h % 4294967296
  end
  return string.format("%08x", h)
end

local function sdbmhash_digest_pair(text)
  return sdbmhash_digest(text), #text
end

return { sdbmhash_digest = sdbmhash_digest, sdbmhash_digest_pair = sdbmhash_digest_pair }
