local function get()
  return { name = "djbhash", category = "hash", key = 8 }
end

local function notes()
  return "hash archetype, fixture key 8"
end

return { get = get, notes = notes }
