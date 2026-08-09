# Round-trip verification for the maskstream cipher.

. ./Ciphers/MaskStream/Cipher.ps1

function Test-MaskStreamRoundTrip {
    param([byte[]] $Sample)
    $encrypted = Invoke-MaskStreamEncrypt -Data $Sample
    $decrypted = Invoke-MaskStreamDecrypt -Data $encrypted
    for ($i = 0; $i -lt $Sample.Length; $i++) {
        if ($decrypted[$i] -ne $Sample[$i]) {
            return $false
        }
    }
    return $true
}

function Get-MaskStreamCheckLabel {
    return "verify:maskstream"
}
