# Box-drawing borders around rendered blocks.

function Get-BorderRule {
    param([int] $Width)
    return "+" + ("-" * $Width) + "+"
}

function Format-Boxed {
    param(
        [string[]] $Lines,
        [int] $Width
    )
    $out = @(Get-BorderRule -Width $Width)
    foreach ($line in $Lines) {
        $out += "|$($line.PadRight($Width))|"
    }
    $out += Get-BorderRule -Width $Width
    return $out
}
