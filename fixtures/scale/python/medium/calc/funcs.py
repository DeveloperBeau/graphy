from calc.registry.registry_trig import trig_table
from calc.registry.registry_logs import logs_table
from calc.registry.registry_round import round_table
from calc.registry.registry_convert import convert_table
from calc.registry.registry_binary import binary_table


def full_table():
    table = {}
    table.update(trig_table())
    table.update(logs_table())
    table.update(round_table())
    table.update(convert_table())
    table.update(binary_table())
    return table


def apply_named(name, args):
    fn = full_table()[name]
    return fn(*args)
