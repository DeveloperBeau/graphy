local check_blockrotate = require("checks.check_blockrotate")
local check_ringshift = require("checks.check_ringshift")
local check_carousel = require("checks.check_carousel")
local check_conveyor = require("checks.check_conveyor")
local check_turnstile = require("checks.check_turnstile")
local check_windmill = require("checks.check_windmill")
local check_ferris = require("checks.check_ferris")
local check_lattice = require("checks.check_lattice")

local function rotate_checks()
  return {
    { "blockrotate", check_blockrotate.check_blockrotate },
    { "ringshift", check_ringshift.check_ringshift },
    { "carousel", check_carousel.check_carousel },
    { "conveyor", check_conveyor.check_conveyor },
    { "turnstile", check_turnstile.check_turnstile },
    { "windmill", check_windmill.check_windmill },
    { "ferris", check_ferris.check_ferris },
    { "lattice", check_lattice.check_lattice },
  }
end

return { rotate_checks = rotate_checks }
