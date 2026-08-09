import byteflip from '../ciphers/byteflip.js';
import byteflipSpecMod from '../specs/byteflipSpec.js';
import corpusCodecMod from '../corpus/corpusCodec.js';

function checkByteflip() {
  const spec = byteflipSpecMod.byteflipSpec();
  for (const text of corpusCodecMod.corpusCodec()) {
    const packed = byteflip.byteflipEncode(text);
    if (byteflip.byteflipDecode(packed) !== text) return false;
  }
  return spec.category === 'codec';
}

export default { checkByteflip };
