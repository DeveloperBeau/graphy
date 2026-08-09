-- Named calculator function: conv radians.
local mathutil = require("src.mathutil")

local function conv_radians(x)
  local value = mathutil.guard_number(x)
  return value * math.pi / 180
end

return { conv_radians = conv_radians }
