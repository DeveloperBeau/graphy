# Hardware notes

The reference fleet is small on purpose: one server part, one desktop
part and one low-power board, refreshed every few years.

## Current fleet

The server part has wide vector units that flatter parallel designs;
the board has none, which is exactly why it stays in the fleet. When a
chapter says a cipher is "fast", check which machine the claim comes
from — the guides in [throughput](throughput.md) always name the machine.

## Adding a machine

Run the calibration workload from [how runs work](methodology.md) and
commit the machine profile it prints. Results from uncalibrated
machines are refused by the store described in
[the results store](results-store.md).
