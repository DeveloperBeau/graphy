local function require_nonempty(text)
  if text == nil or text == "" then error("empty input") end
  return text
end

local function clamp_shift(shift)
  return ((shift % 26) + 26) % 26
end

return { require_nonempty = require_nonempty, clamp_shift = clamp_shift }
