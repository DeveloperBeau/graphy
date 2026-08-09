import riverstream from '../ciphers/riverstream.js';
import riverstreamSpecMod from '../specs/riverstreamSpec.js';
import corpusStreamMod from '../corpus/corpusStream.js';

function checkRiverstream() {
  const spec = riverstreamSpecMod.riverstreamSpec();
  for (const text of corpusStreamMod.corpusStream()) {
    const sealed = riverstream.riverstreamEncrypt(text, spec.key);
    const opened = riverstream.riverstreamDecrypt(sealed, spec.key);
    if (opened !== text) return false;
  }
  return spec.category === 'stream';
}

export default { checkRiverstream };
