local log_natural = require("src.functions.log_natural")
local log_common = require("src.functions.log_common")
local log_binary = require("src.functions.log_binary")
local pow_sqrt = require("src.functions.pow_sqrt")
local pow_cbrt = require("src.functions.pow_cbrt")
local pow_square = require("src.functions.pow_square")
local pow_cube = require("src.functions.pow_cube")
local pow_exp = require("src.functions.pow_exp")

local function logs_table()
  return {
    log_natural = log_natural.log_natural,
    log_common = log_common.log_common,
    log_binary = log_binary.log_binary,
    pow_sqrt = pow_sqrt.pow_sqrt,
    pow_cbrt = pow_cbrt.pow_cbrt,
    pow_square = pow_square.pow_square,
    pow_cube = pow_cube.pow_cube,
    pow_exp = pow_exp.pow_exp,
  }
end

return { logs_table = logs_table }
