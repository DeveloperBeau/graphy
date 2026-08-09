import checkLcgstream from '../checks/checkLcgstream.js';
import checkDriftstream from '../checks/checkDriftstream.js';
import checkPulsestream from '../checks/checkPulsestream.js';
import checkCascadestream from '../checks/checkCascadestream.js';
import checkOrbitstream from '../checks/checkOrbitstream.js';
import checkEmberstream from '../checks/checkEmberstream.js';
import checkRiverstream from '../checks/checkRiverstream.js';
import checkSparkstream from '../checks/checkSparkstream.js';

function streamChecks() {
  return [
    ['lcgstream', checkLcgstream.checkLcgstream],
    ['driftstream', checkDriftstream.checkDriftstream],
    ['pulsestream', checkPulsestream.checkPulsestream],
    ['cascadestream', checkCascadestream.checkCascadestream],
    ['orbitstream', checkOrbitstream.checkOrbitstream],
    ['emberstream', checkEmberstream.checkEmberstream],
    ['riverstream', checkRiverstream.checkRiverstream],
    ['sparkstream', checkSparkstream.checkSparkstream],
  ];
}

export default { streamChecks };
