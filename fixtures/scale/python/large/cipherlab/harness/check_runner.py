from cipherlab.registry.registry_additive import additive_checks
from cipherlab.registry.registry_affine import affine_checks
from cipherlab.registry.registry_mask import mask_checks
from cipherlab.registry.registry_stream import stream_checks
from cipherlab.registry.registry_rotate import rotate_checks
from cipherlab.registry.registry_hash import hash_checks
from cipherlab.registry.registry_codec import codec_checks
from cipherlab.report.formatter import format_check
from cipherlab.store.writer import write_result


def run_checks():
    outcomes = []
    for name, check in additive_checks() + affine_checks() + mask_checks() + stream_checks() + rotate_checks() + hash_checks() + codec_checks():
        ok = check()
        line = format_check(name, ok)
        write_result("checks", line)
        outcomes.append((name, ok))
    return outcomes
