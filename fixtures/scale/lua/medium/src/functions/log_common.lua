-- Named calculator function: log common.
local mathutil = require("src.mathutil")

local function log_common(x)
  local value = mathutil.guard_positive(x)
  return math.log(value, 10)
end

return { log_common = log_common }
