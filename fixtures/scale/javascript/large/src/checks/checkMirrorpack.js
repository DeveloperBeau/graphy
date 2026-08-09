import mirrorpack from '../ciphers/mirrorpack.js';
import mirrorpackSpecMod from '../specs/mirrorpackSpec.js';
import corpusCodecMod from '../corpus/corpusCodec.js';

function checkMirrorpack() {
  const spec = mirrorpackSpecMod.mirrorpackSpec();
  for (const text of corpusCodecMod.corpusCodec()) {
    const packed = mirrorpack.mirrorpackEncode(text);
    if (mirrorpack.mirrorpackDecode(packed) !== text) return false;
  }
  return spec.category === 'codec';
}

export default { checkMirrorpack };
