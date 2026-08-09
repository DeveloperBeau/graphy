from cipherlab.checks.check_fnvhash import check_fnvhash
from cipherlab.checks.check_djbhash import check_djbhash
from cipherlab.checks.check_sdbmhash import check_sdbmhash
from cipherlab.checks.check_jenkinshash import check_jenkinshash
from cipherlab.checks.check_pearsonhash import check_pearsonhash
from cipherlab.checks.check_foldsum import check_foldsum
from cipherlab.checks.check_mixcrc import check_mixcrc
from cipherlab.checks.check_tallyhash import check_tallyhash
from cipherlab.checks.check_chainhash import check_chainhash
from cipherlab.checks.check_weavehash import check_weavehash


def hash_checks():
    return [
        ("fnvhash", check_fnvhash),
        ("djbhash", check_djbhash),
        ("sdbmhash", check_sdbmhash),
        ("jenkinshash", check_jenkinshash),
        ("pearsonhash", check_pearsonhash),
        ("foldsum", check_foldsum),
        ("mixcrc", check_mixcrc),
        ("tallyhash", check_tallyhash),
        ("chainhash", check_chainhash),
        ("weavehash", check_weavehash),
    ]
