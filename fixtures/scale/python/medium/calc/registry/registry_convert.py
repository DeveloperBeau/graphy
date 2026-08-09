from calc.functions.conv_radians import conv_radians
from calc.functions.conv_degrees import conv_degrees
from calc.functions.conv_celsius import conv_celsius
from calc.functions.conv_fahrenheit import conv_fahrenheit


def convert_table():
    return {
        "conv_radians": conv_radians,
        "conv_degrees": conv_degrees,
        "conv_celsius": conv_celsius,
        "conv_fahrenheit": conv_fahrenheit,
    }
