import driftstream from '../ciphers/driftstream.js';
import driftstreamSpecMod from '../specs/driftstreamSpec.js';
import corpusStreamMod from '../corpus/corpusStream.js';

function checkDriftstream() {
  const spec = driftstreamSpecMod.driftstreamSpec();
  for (const text of corpusStreamMod.corpusStream()) {
    const sealed = driftstream.driftstreamEncrypt(text, spec.key);
    const opened = driftstream.driftstreamDecrypt(sealed, spec.key);
    if (opened !== text) return false;
  }
  return spec.category === 'stream';
}

export default { checkDriftstream };
