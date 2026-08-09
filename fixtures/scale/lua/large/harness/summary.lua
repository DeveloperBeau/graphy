local assertions = require("harness.assertions")
local formatter = require("report.formatter")
local reader = require("store.reader")

local function summarize(results)
  local passed = assertions.count_ok(results)
  local logged = reader.count_lines("session")
  return formatter.format_header() .. "\n" ..
    passed .. "/" .. #results .. " passed, " .. logged .. " logged"
end

local function summarize_checks(outcomes)
  local good = 0
  for _, o in ipairs(outcomes) do
    if o[2] then good = good + 1 end
  end
  return good .. "/" .. #outcomes .. " family checks passed"
end

return { summarize = summarize, summarize_checks = summarize_checks }
