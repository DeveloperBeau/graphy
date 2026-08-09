# Console color helpers.

function Get-ColorCode {
    param([string] $Name)
    switch ($Name) {
        "red" { 31 }
        "green" { 32 }
        "yellow" { 33 }
        "blue" { 34 }
        "cyan" { 36 }
        default { 0 }
    }
}

function Format-Colored {
    param(
        [string] $Name,
        [string] $Text
    )
    $code = Get-ColorCode -Name $Name
    return "$([char]27)[${code}m$Text$([char]27)[0m"
}
