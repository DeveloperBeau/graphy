# Load and register the stream cipher family.

. ./Ciphers/XorBasic/Runner.ps1
. ./Ciphers/XorBasic/Check.ps1
. ./Ciphers/XorRoll/Runner.ps1
. ./Ciphers/XorRoll/Check.ps1
. ./Ciphers/Rc4Lite/Runner.ps1
. ./Ciphers/Rc4Lite/Check.ps1
. ./Ciphers/LcgStream/Runner.ps1
. ./Ciphers/LcgStream/Check.ps1
. ./Ciphers/XorShift/Runner.ps1
. ./Ciphers/XorShift/Check.ps1
. ./Ciphers/Feistel/Runner.ps1
. ./Ciphers/Feistel/Check.ps1
. ./Ciphers/CbcXor/Runner.ps1
. ./Ciphers/CbcXor/Check.ps1
. ./Ciphers/CtrXor/Runner.ps1
. ./Ciphers/CtrXor/Check.ps1
. ./Ciphers/MaskStream/Runner.ps1
. ./Ciphers/MaskStream/Check.ps1

function Register-StreamFamily {
    Register-Cipher -Name "xorbasic"
    Register-Cipher -Name "xorroll"
    Register-Cipher -Name "rc4lite"
    Register-Cipher -Name "lcgstream"
    Register-Cipher -Name "xorshift"
    Register-Cipher -Name "feistel"
    Register-Cipher -Name "cbcxor"
    Register-Cipher -Name "ctrxor"
    Register-Cipher -Name "maskstream"
}
