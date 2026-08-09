import stridecode from '../ciphers/stridecode.js';
import stridecodeSpecMod from '../specs/stridecodeSpec.js';
import corpusCodecMod from '../corpus/corpusCodec.js';

function checkStridecode() {
  const spec = stridecodeSpecMod.stridecodeSpec();
  for (const text of corpusCodecMod.corpusCodec()) {
    const packed = stridecode.stridecodeEncode(text);
    if (stridecode.stridecodeDecode(packed) !== text) return false;
  }
  return spec.category === 'codec';
}

export default { checkStridecode };
