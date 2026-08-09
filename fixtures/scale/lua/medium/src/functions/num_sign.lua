-- Named calculator function: num sign.
local mathutil = require("src.mathutil")

local function num_sign(x)
  local value = mathutil.guard_number(x)
  return (value > 0 and 1) or (value < 0 and -1) or 0
end

return { num_sign = num_sign }
