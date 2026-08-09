local codec = require("core.codec")

local function digest_line(result)
  return result.name .. ":" .. codec.fingerprint(result.fp)
end

local function digest_all(results)
  local parts = {}
  for i, r in ipairs(results) do parts[i] = digest_line(r) end
  return table.concat(parts, "|")
end

return { digest_line = digest_line, digest_all = digest_all }
