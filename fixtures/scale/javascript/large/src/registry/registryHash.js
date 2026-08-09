import checkFnvhash from '../checks/checkFnvhash.js';
import checkDjbhash from '../checks/checkDjbhash.js';
import checkSdbmhash from '../checks/checkSdbmhash.js';
import checkJenkinshash from '../checks/checkJenkinshash.js';
import checkPearsonhash from '../checks/checkPearsonhash.js';
import checkFoldsum from '../checks/checkFoldsum.js';
import checkMixcrc from '../checks/checkMixcrc.js';
import checkTallyhash from '../checks/checkTallyhash.js';
import checkChainhash from '../checks/checkChainhash.js';
import checkWeavehash from '../checks/checkWeavehash.js';

function hashChecks() {
  return [
    ['fnvhash', checkFnvhash.checkFnvhash],
    ['djbhash', checkDjbhash.checkDjbhash],
    ['sdbmhash', checkSdbmhash.checkSdbmhash],
    ['jenkinshash', checkJenkinshash.checkJenkinshash],
    ['pearsonhash', checkPearsonhash.checkPearsonhash],
    ['foldsum', checkFoldsum.checkFoldsum],
    ['mixcrc', checkMixcrc.checkMixcrc],
    ['tallyhash', checkTallyhash.checkTallyhash],
    ['chainhash', checkChainhash.checkChainhash],
    ['weavehash', checkWeavehash.checkWeavehash],
  ];
}

export default { hashChecks };
