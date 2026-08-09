-- Named calculator function: conv celsius.
local mathutil = require("src.mathutil")

local function conv_celsius(x)
  local value = mathutil.guard_number(x)
  return (value - 32) * 5 / 9
end

return { conv_celsius = conv_celsius }
