# feature: function, param block
function Format-Name {
    param(
        [string] $Name
    )
    return "hi, $Name"
}

function Get-UnrelatedHelper {
    return 7
}
