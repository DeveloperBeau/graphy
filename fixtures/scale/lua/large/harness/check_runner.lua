local registry_additive = require("registry.registry_additive")
local registry_affine = require("registry.registry_affine")
local registry_mask = require("registry.registry_mask")
local registry_stream = require("registry.registry_stream")
local registry_rotate = require("registry.registry_rotate")
local registry_hash = require("registry.registry_hash")
local registry_codec = require("registry.registry_codec")
local formatter = require("report.formatter")
local writer = require("store.writer")

local function collect_all()
  local all = {}
  for _, cat in ipairs({
    registry_additive.additive_checks(),
    registry_affine.affine_checks(),
    registry_mask.mask_checks(),
    registry_stream.stream_checks(),
    registry_rotate.rotate_checks(),
    registry_hash.hash_checks(),
    registry_codec.codec_checks(),
  }) do
    for _, entry in ipairs(cat) do table.insert(all, entry) end
  end
  return all
end

local function run_checks()
  local outcomes = {}
  for _, entry in ipairs(collect_all()) do
    local name, check = entry[1], entry[2]
    local ok = check()
    writer.write_result("checks", formatter.format_check(name, ok))
    table.insert(outcomes, { name, ok })
  end
  return outcomes
end

return { run_checks = run_checks }
