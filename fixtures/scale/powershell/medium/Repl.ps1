# Interactive read-eval-print loop.

function Read-CalcLine {
    return Read-Host "calc"
}

function Start-CalcRepl {
    while ($true) {
        $line = Read-CalcLine
        if ($line -eq "quit") {
            break
        }
        try {
            $result = Invoke-CalcEvaluate -Expression $line
            Add-CalcHistory -Expression $line -Result $result
            Write-Host (Format-CalcResult -Value $result)
        } catch {
            Set-CalcError -Message $_.Exception.Message
            Write-Host "error: $(Get-CalcError)"
        }
    }
}
