import zigzagpack from '../ciphers/zigzagpack.js';
import zigzagpackSpecMod from '../specs/zigzagpackSpec.js';
import corpusCodecMod from '../corpus/corpusCodec.js';

function checkZigzagpack() {
  const spec = zigzagpackSpecMod.zigzagpackSpec();
  for (const text of corpusCodecMod.corpusCodec()) {
    const packed = zigzagpack.zigzagpackEncode(text);
    if (zigzagpack.zigzagpackDecode(packed) !== text) return false;
  }
  return spec.category === 'codec';
}

export default { checkZigzagpack };
