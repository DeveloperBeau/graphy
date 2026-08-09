# Round-trip verification for the addmod cipher.

. ./Ciphers/Addmod/Cipher.ps1

function Test-AddmodRoundTrip {
    param([byte[]] $Sample)
    $encrypted = Invoke-AddmodEncrypt -Data $Sample
    $decrypted = Invoke-AddmodDecrypt -Data $encrypted
    for ($i = 0; $i -lt $Sample.Length; $i++) {
        if ($decrypted[$i] -ne $Sample[$i]) {
            return $false
        }
    }
    return $true
}

function Get-AddmodCheckLabel {
    return "verify:addmod"
}
