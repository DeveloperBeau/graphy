local registry_trig = require("src.registry.registry_trig")
local registry_logs = require("src.registry.registry_logs")
local registry_round = require("src.registry.registry_round")
local registry_convert = require("src.registry.registry_convert")
local registry_binary = require("src.registry.registry_binary")

local function full_table()
  local out = {}
  for _, tbl in ipairs({
    registry_trig.trig_table(),
    registry_logs.logs_table(),
    registry_round.round_table(),
    registry_convert.convert_table(),
    registry_binary.binary_table(),
  }) do
    for k, v in pairs(tbl) do out[k] = v end
  end
  return out
end

local function apply_named(name, args)
  local fn = full_table()[name]
  return fn(table.unpack(args))
end

return { full_table = full_table, apply_named = apply_named }
