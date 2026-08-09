local pipeline = require("core.pipeline")
local cases = require("harness.cases")
local live = require("report.live")
local writer = require("store.writer")

local function run_all()
  live.emit_banner("starting")
  writer.clear_result("session")
  local results = {}
  for _, case in ipairs(cases.build_cases()) do
    local result = pipeline.round_trip(case[1], case[2], case[3])
    local line = live.emit(result)
    writer.write_result("session", line)
    table.insert(results, result)
  end
  return results
end

return { run_all = run_all }
