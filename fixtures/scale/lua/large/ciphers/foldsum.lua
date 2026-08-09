local bytes = require("util.bytes")

local function foldsum_digest(text)
  local h = 40503
  for _, v in ipairs(bytes.to_codes(text)) do
    h = (h * 40503) ~ v
    h = h % 4294967296
  end
  return string.format("%08x", h)
end

local function foldsum_digest_pair(text)
  return foldsum_digest(text), #text
end

return { foldsum_digest = foldsum_digest, foldsum_digest_pair = foldsum_digest_pair }
