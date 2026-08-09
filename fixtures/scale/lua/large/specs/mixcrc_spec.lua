local function get()
  return { name = "mixcrc", category = "hash", key = 13 }
end

local function notes()
  return "hash archetype, fixture key 13"
end

return { get = get, notes = notes }
