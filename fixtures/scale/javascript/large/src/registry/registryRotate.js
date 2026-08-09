import checkBlockrotate from '../checks/checkBlockrotate.js';
import checkRingshift from '../checks/checkRingshift.js';
import checkCarousel from '../checks/checkCarousel.js';
import checkConveyor from '../checks/checkConveyor.js';
import checkTurnstile from '../checks/checkTurnstile.js';
import checkWindmill from '../checks/checkWindmill.js';
import checkFerris from '../checks/checkFerris.js';
import checkLattice from '../checks/checkLattice.js';

function rotateChecks() {
  return [
    ['blockrotate', checkBlockrotate.checkBlockrotate],
    ['ringshift', checkRingshift.checkRingshift],
    ['carousel', checkCarousel.checkCarousel],
    ['conveyor', checkConveyor.checkConveyor],
    ['turnstile', checkTurnstile.checkTurnstile],
    ['windmill', checkWindmill.checkWindmill],
    ['ferris', checkFerris.checkFerris],
    ['lattice', checkLattice.checkLattice],
  ];
}

export default { rotateChecks };
