# Load and register the transposition cipher family.

. ./Ciphers/RailFence/Runner.ps1
. ./Ciphers/RailFence/Check.ps1
. ./Ciphers/Columnar/Runner.ps1
. ./Ciphers/Columnar/Check.ps1
. ./Ciphers/Scytale/Runner.ps1
. ./Ciphers/Scytale/Check.ps1
. ./Ciphers/RevBlocks/Runner.ps1
. ./Ciphers/RevBlocks/Check.ps1
. ./Ciphers/ZigZag/Runner.ps1
. ./Ciphers/ZigZag/Check.ps1
. ./Ciphers/BlockSwap/Runner.ps1
. ./Ciphers/BlockSwap/Check.ps1
. ./Ciphers/RotBlocks/Runner.ps1
. ./Ciphers/RotBlocks/Check.ps1
. ./Ciphers/Interleave/Runner.ps1
. ./Ciphers/Interleave/Check.ps1
. ./Ciphers/Stride/Runner.ps1
. ./Ciphers/Stride/Check.ps1

function Register-TranspositionFamily {
    Register-Cipher -Name "railfence"
    Register-Cipher -Name "columnar"
    Register-Cipher -Name "scytale"
    Register-Cipher -Name "revblocks"
    Register-Cipher -Name "zigzag"
    Register-Cipher -Name "blockswap"
    Register-Cipher -Name "rotblocks"
    Register-Cipher -Name "interleave"
    Register-Cipher -Name "stride"
}
