local check_hexpack = require("checks.check_hexpack")
local check_nibbleswap = require("checks.check_nibbleswap")
local check_byteflip = require("checks.check_byteflip")
local check_pairswap = require("checks.check_pairswap")
local check_mirrorpack = require("checks.check_mirrorpack")
local check_zigzagpack = require("checks.check_zigzagpack")
local check_splitpack = require("checks.check_splitpack")
local check_laddercode = require("checks.check_laddercode")
local check_weavecode = require("checks.check_weavecode")
local check_stridecode = require("checks.check_stridecode")

local function codec_checks()
  return {
    { "hexpack", check_hexpack.check_hexpack },
    { "nibbleswap", check_nibbleswap.check_nibbleswap },
    { "byteflip", check_byteflip.check_byteflip },
    { "pairswap", check_pairswap.check_pairswap },
    { "mirrorpack", check_mirrorpack.check_mirrorpack },
    { "zigzagpack", check_zigzagpack.check_zigzagpack },
    { "splitpack", check_splitpack.check_splitpack },
    { "laddercode", check_laddercode.check_laddercode },
    { "weavecode", check_weavecode.check_weavecode },
    { "stridecode", check_stridecode.check_stridecode },
  }
end

return { codec_checks = codec_checks }
