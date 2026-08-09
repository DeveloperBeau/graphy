# Load and register the hash cipher family.

. ./Ciphers/Fnv1a/Runner.ps1
. ./Ciphers/Fnv1a/Check.ps1
. ./Ciphers/Djb2/Runner.ps1
. ./Ciphers/Djb2/Check.ps1
. ./Ciphers/Sdbm/Runner.ps1
. ./Ciphers/Sdbm/Check.ps1
. ./Ciphers/Adler/Runner.ps1
. ./Ciphers/Adler/Check.ps1
. ./Ciphers/Sum32/Runner.ps1
. ./Ciphers/Sum32/Check.ps1
. ./Ciphers/XorDigest/Runner.ps1
. ./Ciphers/XorDigest/Check.ps1
. ./Ciphers/CrcLite/Runner.ps1
. ./Ciphers/CrcLite/Check.ps1
. ./Ciphers/RotHash/Runner.ps1
. ./Ciphers/RotHash/Check.ps1
. ./Ciphers/ProdHash/Runner.ps1
. ./Ciphers/ProdHash/Check.ps1

function Register-HashFamily {
    Register-Cipher -Name "fnv1a"
    Register-Cipher -Name "djb2"
    Register-Cipher -Name "sdbm"
    Register-Cipher -Name "adler"
    Register-Cipher -Name "sum32"
    Register-Cipher -Name "xordigest"
    Register-Cipher -Name "crclite"
    Register-Cipher -Name "rothash"
    Register-Cipher -Name "prodhash"
}
