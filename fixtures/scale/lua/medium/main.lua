local repl = require("src.repl")
local funcs = require("src.funcs")

local function main()
  local exprs = { "1 + 2 * 3", "(4 + 5) / 3", "2 ^ 8", "10 - 4 - 3" }
  local log = repl.run_batch(exprs)
  print("---")
  print(require("src.history").dump(log))
  print(funcs.apply_named("trig_sine", { 0.5 }))
  print(funcs.apply_named("bi_hypotenuse", { 3, 4 }))
end

main()
