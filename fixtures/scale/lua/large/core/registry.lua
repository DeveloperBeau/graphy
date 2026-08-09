local caesar = require("ciphers.caesar")
local xorkey = require("ciphers.xorkey")
local lcgstream = require("ciphers.lcgstream")
local carousel = require("ciphers.carousel")
local errors = require("util.errors")

local function get_cipher(name)
  local table_of = {
    caesar = { caesar.caesar_encrypt, caesar.caesar_decrypt },
    xorkey = { xorkey.xorkey_encrypt, xorkey.xorkey_decrypt },
    lcgstream = { lcgstream.lcgstream_encrypt, lcgstream.lcgstream_decrypt },
    carousel = { carousel.carousel_encrypt, carousel.carousel_decrypt },
  }
  local pair = table_of[name]
  if not pair then error(errors.unknown_cipher(name)) end
  return pair
end

return { get_cipher = get_cipher }
