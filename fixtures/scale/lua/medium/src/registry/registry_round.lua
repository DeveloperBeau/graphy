local round_floor = require("src.functions.round_floor")
local round_ceil = require("src.functions.round_ceil")
local round_nearest = require("src.functions.round_nearest")
local round_trunc = require("src.functions.round_trunc")
local num_absolute = require("src.functions.num_absolute")
local num_sign = require("src.functions.num_sign")

local function round_table()
  return {
    round_floor = round_floor.round_floor,
    round_ceil = round_ceil.round_ceil,
    round_nearest = round_nearest.round_nearest,
    round_trunc = round_trunc.round_trunc,
    num_absolute = num_absolute.num_absolute,
    num_sign = num_sign.num_sign,
  }
end

return { round_table = round_table }
