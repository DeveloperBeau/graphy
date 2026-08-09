import cascadestream from '../ciphers/cascadestream.js';
import cascadestreamSpecMod from '../specs/cascadestreamSpec.js';
import corpusStreamMod from '../corpus/corpusStream.js';

function checkCascadestream() {
  const spec = cascadestreamSpecMod.cascadestreamSpec();
  for (const text of corpusStreamMod.corpusStream()) {
    const sealed = cascadestream.cascadestreamEncrypt(text, spec.key);
    const opened = cascadestream.cascadestreamDecrypt(sealed, spec.key);
    if (opened !== text) return false;
  }
  return spec.category === 'stream';
}

export default { checkCascadestream };
