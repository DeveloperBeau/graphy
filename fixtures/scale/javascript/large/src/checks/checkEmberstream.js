import emberstream from '../ciphers/emberstream.js';
import emberstreamSpecMod from '../specs/emberstreamSpec.js';
import corpusStreamMod from '../corpus/corpusStream.js';

function checkEmberstream() {
  const spec = emberstreamSpecMod.emberstreamSpec();
  for (const text of corpusStreamMod.corpusStream()) {
    const sealed = emberstream.emberstreamEncrypt(text, spec.key);
    const opened = emberstream.emberstreamDecrypt(sealed, spec.key);
    if (opened !== text) return false;
  }
  return spec.category === 'stream';
}

export default { checkEmberstream };
