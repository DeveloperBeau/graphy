-- Named calculator function: num absolute.
local mathutil = require("src.mathutil")

local function num_absolute(x)
  local value = mathutil.guard_number(x)
  return math.abs(value)
end

return { num_absolute = num_absolute }
