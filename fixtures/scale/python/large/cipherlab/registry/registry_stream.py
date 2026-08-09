from cipherlab.checks.check_lcgstream import check_lcgstream
from cipherlab.checks.check_driftstream import check_driftstream
from cipherlab.checks.check_pulsestream import check_pulsestream
from cipherlab.checks.check_cascadestream import check_cascadestream
from cipherlab.checks.check_orbitstream import check_orbitstream
from cipherlab.checks.check_emberstream import check_emberstream
from cipherlab.checks.check_riverstream import check_riverstream
from cipherlab.checks.check_sparkstream import check_sparkstream


def stream_checks():
    return [
        ("lcgstream", check_lcgstream),
        ("driftstream", check_driftstream),
        ("pulsestream", check_pulsestream),
        ("cascadestream", check_cascadestream),
        ("orbitstream", check_orbitstream),
        ("emberstream", check_emberstream),
        ("riverstream", check_riverstream),
        ("sparkstream", check_sparkstream),
    ]
