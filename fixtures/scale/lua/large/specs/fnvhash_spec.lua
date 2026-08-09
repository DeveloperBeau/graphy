local function get()
  return { name = "fnvhash", category = "hash", key = 7 }
end

local function notes()
  return "hash archetype, fixture key 7"
end

return { get = get, notes = notes }
