# banner subcommand: one centered, framed headline.

. ./Lib/Colors.ps1
. ./Lib/Align.ps1
. ./Lib/Border.ps1
. ./Lib/Log.ps1

function Invoke-BannerCommand {
    param([string] $Text)
    $width = Get-TextPrintSetting -Name "Width"
    Write-InfoLog -Message "banner width=$width"
    $centered = Format-Centered -Text $Text -Width $width
    (Format-Boxed -Lines @($centered) -Width $width) | ForEach-Object { Write-Host $_ }
}

function Get-BannerPreview {
    param([string] $Text)
    return (Format-Colored -Name "cyan" -Text (Format-Centered -Text $Text -Width 40))
}
