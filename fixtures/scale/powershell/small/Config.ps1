# Runtime defaults, overridable via TEXTPRINT_* environment variables.

$script:TextPrintSettings = @{
    Width = if ($env:TEXTPRINT_WIDTH) { [int]$env:TEXTPRINT_WIDTH } else { 72 }
    Style = if ($env:TEXTPRINT_STYLE) { $env:TEXTPRINT_STYLE } else { "plain" }
    Color = if ($env:TEXTPRINT_COLOR) { $env:TEXTPRINT_COLOR } else { "auto" }
}

function Get-TextPrintSetting {
    param([string] $Name)
    return $script:TextPrintSettings[$Name]
}

function Test-ColorEnabled {
    return (Get-TextPrintSetting -Name "Color") -ne "never"
}
