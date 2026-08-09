import registryTrig from './registry/registryTrig.js';
import registryLogs from './registry/registryLogs.js';
import registryRound from './registry/registryRound.js';
import registryConvert from './registry/registryConvert.js';
import registryBinary from './registry/registryBinary.js';

function fullTable() {
  return {
    ...registryTrig.trigTable(),
    ...registryLogs.logsTable(),
    ...registryRound.roundTable(),
    ...registryConvert.convertTable(),
    ...registryBinary.binaryTable(),
  };
}

function applyNamed(name, args) {
  const fn = fullTable()[name];
  return fn(...args);
}

export default { fullTable, applyNamed };
