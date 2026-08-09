module Core.Registry (Entry(..), catalog, size) where

import qualified Ciphers.Aes128.Runner as Aes128
import qualified Ciphers.Blowfish256.Runner as Blowfish
import qualified Ciphers.Chacha20256.Runner as Chacha20
import qualified Ciphers.Salsa20256.Runner as Salsa20

data Entry = Entry { entryLabel :: String }

catalog :: [Entry]
catalog =
  [ Entry Aes128.label
  , Entry Chacha20.label
  , Entry Salsa20.label
  , Entry Blowfish.label
  ]

size :: Int
size = length catalog
