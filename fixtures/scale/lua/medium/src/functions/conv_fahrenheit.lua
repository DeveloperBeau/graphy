-- Named calculator function: conv fahrenheit.
local mathutil = require("src.mathutil")

local function conv_fahrenheit(x)
  local value = mathutil.guard_number(x)
  return value * 9 / 5 + 32
end

return { conv_fahrenheit = conv_fahrenheit }
