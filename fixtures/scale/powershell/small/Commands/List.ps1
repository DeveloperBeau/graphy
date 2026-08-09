# list subcommand: bulleted items from arguments.

. ./Lib/Style.ps1
. ./Lib/Log.ps1

function Format-ListItem {
    param([string] $Item)
    return "  * $Item"
}

function Invoke-ListCommand {
    param([string[]] $Items)
    Write-InfoLog -Message "list with $($Items.Count) items"
    foreach ($item in $Items) {
        Write-Host (Format-ListItem -Item $item)
    }
}
