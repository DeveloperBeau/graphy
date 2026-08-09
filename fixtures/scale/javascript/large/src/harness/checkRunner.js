import registryAdditive from '../registry/registryAdditive.js';
import registryAffine from '../registry/registryAffine.js';
import registryMask from '../registry/registryMask.js';
import registryStream from '../registry/registryStream.js';
import registryRotate from '../registry/registryRotate.js';
import registryHash from '../registry/registryHash.js';
import registryCodec from '../registry/registryCodec.js';
import formatter from '../report/formatter.js';
import writer from '../store/writer.js';

function runChecks() {
  const outcomes = [];
  for (const [name, check] of [...registryAdditive.additiveChecks(), ...registryAffine.affineChecks(), ...registryMask.maskChecks(), ...registryStream.streamChecks(), ...registryRotate.rotateChecks(), ...registryHash.hashChecks(), ...registryCodec.codecChecks()]) {
    const ok = check();
    writer.writeResult('checks', formatter.formatCheck(name, ok));
    outcomes.push([name, ok]);
  }
  return outcomes;
}

export default { runChecks };
