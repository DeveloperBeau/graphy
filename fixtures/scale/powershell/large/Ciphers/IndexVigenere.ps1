# Load and register the vigenere cipher family.

. ./Ciphers/Vigenere/Runner.ps1
. ./Ciphers/Vigenere/Check.ps1
. ./Ciphers/Beaufort/Runner.ps1
. ./Ciphers/Beaufort/Check.ps1
. ./Ciphers/Autokey/Runner.ps1
. ./Ciphers/Autokey/Check.ps1
. ./Ciphers/Gronsfeld/Runner.ps1
. ./Ciphers/Gronsfeld/Check.ps1
. ./Ciphers/Porta/Runner.ps1
. ./Ciphers/Porta/Check.ps1
. ./Ciphers/Runkey/Runner.ps1
. ./Ciphers/Runkey/Check.ps1
. ./Ciphers/Keymix/Runner.ps1
. ./Ciphers/Keymix/Check.ps1
. ./Ciphers/Trithemius/Runner.ps1
. ./Ciphers/Trithemius/Check.ps1
. ./Ciphers/Quagmire/Runner.ps1
. ./Ciphers/Quagmire/Check.ps1

function Register-VigenereFamily {
    Register-Cipher -Name "vigenere"
    Register-Cipher -Name "beaufort"
    Register-Cipher -Name "autokey"
    Register-Cipher -Name "gronsfeld"
    Register-Cipher -Name "porta"
    Register-Cipher -Name "runkey"
    Register-Cipher -Name "keymix"
    Register-Cipher -Name "trithemius"
    Register-Cipher -Name "quagmire"
}
