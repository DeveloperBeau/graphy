# Names of every registered cipher, in run order.

$script:CipherNames = @()

function Register-Cipher {
    param([string] $Name)
    $script:CipherNames += $Name
}

function Get-RegisteredCiphers {
    return $script:CipherNames
}

function Get-RegisteredCount {
    return $script:CipherNames.Count
}
