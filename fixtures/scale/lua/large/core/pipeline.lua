local registry = require("core.registry")
local codec = require("core.codec")
local timing = require("util.timing")

local function round_trip(name, text, key)
  local pair = registry.get_cipher(name)
  local start = timing.now_ms()
  local sealed = pair[1](text, key)
  local opened = pair[2](sealed, key)
  return { name = name, ok = opened == text, fp = codec.fingerprint(sealed), ms = timing.elapsed(start) }
end

return { round_trip = round_trip }
