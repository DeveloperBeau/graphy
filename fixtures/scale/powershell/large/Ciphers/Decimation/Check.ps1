# Round-trip verification for the decimation cipher.

. ./Ciphers/Decimation/Cipher.ps1

function Test-DecimationRoundTrip {
    param([byte[]] $Sample)
    $encrypted = Invoke-DecimationEncrypt -Data $Sample
    $decrypted = Invoke-DecimationDecrypt -Data $encrypted
    for ($i = 0; $i -lt $Sample.Length; $i++) {
        if ($decrypted[$i] -ne $Sample[$i]) {
            return $false
        }
    }
    return $true
}

function Get-DecimationCheckLabel {
    return "verify:decimation"
}
