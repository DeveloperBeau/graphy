import sparkstream from '../ciphers/sparkstream.js';
import sparkstreamSpecMod from '../specs/sparkstreamSpec.js';
import corpusStreamMod from '../corpus/corpusStream.js';

function checkSparkstream() {
  const spec = sparkstreamSpecMod.sparkstreamSpec();
  for (const text of corpusStreamMod.corpusStream()) {
    const sealed = sparkstream.sparkstreamEncrypt(text, spec.key);
    const opened = sparkstream.sparkstreamDecrypt(sealed, spec.key);
    if (opened !== text) return false;
  }
  return spec.category === 'stream';
}

export default { checkSparkstream };
