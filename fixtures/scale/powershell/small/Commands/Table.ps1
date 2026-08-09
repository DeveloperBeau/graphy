# table subcommand: two-column key=value rendering.

. ./Lib/Align.ps1
. ./Lib/Log.ps1

function Get-TableSeparator {
    return "-" * 31
}

function Format-TableRow {
    param([string] $Row)
    $key, $value = $Row -split "=", 2
    return "{0,-14} {1}" -f $key, $value
}

function Invoke-TableCommand {
    param([string[]] $Rows)
    Write-Host (Get-TableSeparator)
    foreach ($row in $Rows) {
        Write-Host (Format-TableRow -Row $row)
    }
    Write-Host (Get-TableSeparator)
}
