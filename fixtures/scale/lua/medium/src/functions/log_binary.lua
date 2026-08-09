-- Named calculator function: log binary.
local mathutil = require("src.mathutil")

local function log_binary(x)
  local value = mathutil.guard_positive(x)
  return math.log(value, 2)
end

return { log_binary = log_binary }
