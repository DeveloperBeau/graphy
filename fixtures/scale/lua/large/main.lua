local runner = require("harness.runner")
local check_runner = require("harness.check_runner")
local summary = require("harness.summary")
local live = require("report.live")

local function main()
  local results = runner.run_all()
  live.emit_banner("family checks")
  local outcomes = check_runner.run_checks()
  live.emit_banner("done")
  print(summary.summarize(results))
  print(summary.summarize_checks(outcomes))
end

main()
