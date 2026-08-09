local function get()
  return { name = "jenkinshash", category = "hash", key = 10 }
end

local function notes()
  return "hash archetype, fixture key 10"
end

return { get = get, notes = notes }
