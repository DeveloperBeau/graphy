import lcgstream from '../ciphers/lcgstream.js';
import lcgstreamSpecMod from '../specs/lcgstreamSpec.js';
import corpusStreamMod from '../corpus/corpusStream.js';

function checkLcgstream() {
  const spec = lcgstreamSpecMod.lcgstreamSpec();
  for (const text of corpusStreamMod.corpusStream()) {
    const sealed = lcgstream.lcgstreamEncrypt(text, spec.key);
    const opened = lcgstream.lcgstreamDecrypt(sealed, spec.key);
    if (opened !== text) return false;
  }
  return spec.category === 'stream';
}

export default { checkLcgstream };
