-- Named calculator function: log natural.
local mathutil = require("src.mathutil")

local function log_natural(x)
  local value = mathutil.guard_positive(x)
  return math.log(value)
end

return { log_natural = log_natural }
