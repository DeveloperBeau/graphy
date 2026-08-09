import hexpack from '../ciphers/hexpack.js';
import hexpackSpecMod from '../specs/hexpackSpec.js';
import corpusCodecMod from '../corpus/corpusCodec.js';

function checkHexpack() {
  const spec = hexpackSpecMod.hexpackSpec();
  for (const text of corpusCodecMod.corpusCodec()) {
    const packed = hexpack.hexpackEncode(text);
    if (hexpack.hexpackDecode(packed) !== text) return false;
  }
  return spec.category === 'codec';
}

export default { checkHexpack };
