# Round-trip verification for the rotblocks cipher.

. ./Ciphers/RotBlocks/Cipher.ps1

function Test-RotBlocksRoundTrip {
    param([byte[]] $Sample)
    $encrypted = Invoke-RotBlocksEncrypt -Data $Sample
    $decrypted = Invoke-RotBlocksDecrypt -Data $encrypted
    for ($i = 0; $i -lt $Sample.Length; $i++) {
        if ($decrypted[$i] -ne $Sample[$i]) {
            return $false
        }
    }
    return $true
}

function Get-RotBlocksCheckLabel {
    return "verify:rotblocks"
}
