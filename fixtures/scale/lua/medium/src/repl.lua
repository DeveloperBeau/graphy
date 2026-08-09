local evaluator = require("src.evaluator")
local history = require("src.history")
local formatting = require("src.formatting")

local function run_batch(expressions)
  local log = history.new_history()
  for _, expr in ipairs(expressions) do
    local value = evaluator.evaluate(expr)
    history.record(log, expr, value)
    print(formatting.format_line(expr, value))
  end
  return log
end

return { run_batch = run_batch }
