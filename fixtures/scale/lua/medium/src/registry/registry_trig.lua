local trig_sine = require("src.functions.trig_sine")
local trig_cosine = require("src.functions.trig_cosine")
local trig_tangent = require("src.functions.trig_tangent")
local trig_arctan = require("src.functions.trig_arctan")
local hyp_sinh = require("src.functions.hyp_sinh")
local hyp_cosh = require("src.functions.hyp_cosh")
local hyp_tanh = require("src.functions.hyp_tanh")

local function trig_table()
  return {
    trig_sine = trig_sine.trig_sine,
    trig_cosine = trig_cosine.trig_cosine,
    trig_tangent = trig_tangent.trig_tangent,
    trig_arctan = trig_arctan.trig_arctan,
    hyp_sinh = hyp_sinh.hyp_sinh,
    hyp_cosh = hyp_cosh.hyp_cosh,
    hyp_tanh = hyp_tanh.hyp_tanh,
  }
end

return { trig_table = trig_table }
