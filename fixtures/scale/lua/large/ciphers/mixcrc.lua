local bytes = require("util.bytes")

local function mixcrc_digest(text)
  local h = 654435747
  for _, v in ipairs(bytes.to_codes(text)) do
    h = (h * 427799) ~ v
    h = h % 4294967296
  end
  return string.format("%08x", h)
end

local function mixcrc_digest_pair(text)
  return mixcrc_digest(text), #text
end

return { mixcrc_digest = mixcrc_digest, mixcrc_digest_pair = mixcrc_digest_pair }
