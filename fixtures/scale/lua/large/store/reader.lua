local paths = require("store.paths")

local function read_result(name)
  local lines = {}
  local fh = io.open(paths.result_path(name), "r")
  if not fh then return lines end
  for line in fh:lines() do table.insert(lines, line) end
  fh:close()
  return lines
end

local function count_lines(name)
  return #read_result(name)
end

return { read_result = read_result, count_lines = count_lines }
