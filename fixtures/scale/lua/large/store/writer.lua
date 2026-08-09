local paths = require("store.paths")

local function write_result(name, line)
  os.execute("mkdir -p " .. paths.store_dir())
  local fh = io.open(paths.result_path(name), "a")
  fh:write(line .. "\n")
  fh:close()
end

local function clear_result(name)
  os.execute("mkdir -p " .. paths.store_dir())
  local fh = io.open(paths.result_path(name), "w")
  fh:close()
end

return { write_result = write_result, clear_result = clear_result }
