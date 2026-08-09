# Round-trip verification for the revblocks cipher.

. ./Ciphers/RevBlocks/Cipher.ps1

function Test-RevBlocksRoundTrip {
    param([byte[]] $Sample)
    $encrypted = Invoke-RevBlocksEncrypt -Data $Sample
    $decrypted = Invoke-RevBlocksDecrypt -Data $encrypted
    for ($i = 0; $i -lt $Sample.Length; $i++) {
        if ($decrypted[$i] -ne $Sample[$i]) {
            return $false
        }
    }
    return $true
}

function Get-RevBlocksCheckLabel {
    return "verify:revblocks"
}
