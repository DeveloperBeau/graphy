import splitpack from '../ciphers/splitpack.js';
import splitpackSpecMod from '../specs/splitpackSpec.js';
import corpusCodecMod from '../corpus/corpusCodec.js';

function checkSplitpack() {
  const spec = splitpackSpecMod.splitpackSpec();
  for (const text of corpusCodecMod.corpusCodec()) {
    const packed = splitpack.splitpackEncode(text);
    if (splitpack.splitpackDecode(packed) !== text) return false;
  }
  return spec.category === 'codec';
}

export default { checkSplitpack };
