local function store_dir()
  return "runs"
end

local function result_path(name)
  return store_dir() .. "/" .. name .. ".log"
end

return { store_dir = store_dir, result_path = result_path }
