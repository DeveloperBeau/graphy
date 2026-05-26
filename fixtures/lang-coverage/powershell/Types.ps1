# feature: class (PS 5+), variable
class State {
    [string] $Name
    [bool] $Active

    State([string] $name) {
        $this.Name = $name
        $this.Active = $false
    }
}

$MaxRetries = 3
$ServiceName = "graphy-ps-fixture"
