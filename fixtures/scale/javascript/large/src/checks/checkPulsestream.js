import pulsestream from '../ciphers/pulsestream.js';
import pulsestreamSpecMod from '../specs/pulsestreamSpec.js';
import corpusStreamMod from '../corpus/corpusStream.js';

function checkPulsestream() {
  const spec = pulsestreamSpecMod.pulsestreamSpec();
  for (const text of corpusStreamMod.corpusStream()) {
    const sealed = pulsestream.pulsestreamEncrypt(text, spec.key);
    const opened = pulsestream.pulsestreamDecrypt(sealed, spec.key);
    if (opened !== text) return false;
  }
  return spec.category === 'stream';
}

export default { checkPulsestream };
