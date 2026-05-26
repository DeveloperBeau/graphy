#!/usr/bin/env bash
# feature: variable assignment, function (keyword form)
MAX_RETRIES=3
SERVICE_NAME="graphy-bash-fixture"

function new_state {
    local name="$1"
    echo "$name"
}
