# Load and register the shift cipher family.

. ./Ciphers/Caesar/Runner.ps1
. ./Ciphers/Caesar/Check.ps1
. ./Ciphers/Rot13/Runner.ps1
. ./Ciphers/Rot13/Check.ps1
. ./Ciphers/Rot47/Runner.ps1
. ./Ciphers/Rot47/Check.ps1
. ./Ciphers/Shift5/Runner.ps1
. ./Ciphers/Shift5/Check.ps1
. ./Ciphers/Atbash/Runner.ps1
. ./Ciphers/Atbash/Check.ps1
. ./Ciphers/Affine/Runner.ps1
. ./Ciphers/Affine/Check.ps1
. ./Ciphers/Decimation/Runner.ps1
. ./Ciphers/Decimation/Check.ps1
. ./Ciphers/Addmod/Runner.ps1
. ./Ciphers/Addmod/Check.ps1
. ./Ciphers/Rotmix/Runner.ps1
. ./Ciphers/Rotmix/Check.ps1

function Register-ShiftFamily {
    Register-Cipher -Name "caesar"
    Register-Cipher -Name "rot13"
    Register-Cipher -Name "rot47"
    Register-Cipher -Name "shift5"
    Register-Cipher -Name "atbash"
    Register-Cipher -Name "affine"
    Register-Cipher -Name "decimation"
    Register-Cipher -Name "addmod"
    Register-Cipher -Name "rotmix"
}
