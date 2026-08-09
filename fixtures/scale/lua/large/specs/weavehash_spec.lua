local function get()
  return { name = "weavehash", category = "hash", key = 16 }
end

local function notes()
  return "hash archetype, fixture key 16"
end

return { get = get, notes = notes }
