-- Named calculator function: conv degrees.
local mathutil = require("src.mathutil")

local function conv_degrees(x)
  local value = mathutil.guard_number(x)
  return value * 180 / math.pi
end

return { conv_degrees = conv_degrees }
