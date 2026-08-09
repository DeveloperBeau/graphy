# textprint - render styled text blocks in the terminal.

. ./Config.ps1
. ./Version.ps1
. ./Commands/Banner.ps1
. ./Commands/List.ps1
. ./Commands/Table.ps1

function Show-Usage {
    Write-Host "usage: TextPrint.ps1 <banner|list|table> [args...]"
    Write-Host "  textprint $(Get-TextPrintVersion)"
}

function Invoke-TextPrint {
    param([string[]] $Arguments)
    $command = if ($Arguments.Count -gt 0) { $Arguments[0] } else { "help" }
    $rest = if ($Arguments.Count -gt 1) { $Arguments[1..($Arguments.Count - 1)] } else { @() }
    switch ($command) {
        "banner" { Invoke-BannerCommand -Text ($rest -join " ") }
        "list" { Invoke-ListCommand -Items $rest }
        "table" { Invoke-TableCommand -Rows $rest }
        default { Show-Usage }
    }
}

Invoke-TextPrint -Arguments $args
