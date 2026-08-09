# Configuration file

inkroll reads `~/.config/inkroll/config` at startup when it exists.

## Recognised keys

`width`, `preset` and `rules` mirror their command line flags from
[styles and flags](styles.md); flags always win over file values.

## Example

    width 100
    preset build
    rules ~/.config/inkroll/rules.conf

The rules file format is covered under [colour rules](colour-rules.md).
