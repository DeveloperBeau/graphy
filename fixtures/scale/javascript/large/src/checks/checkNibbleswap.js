import nibbleswap from '../ciphers/nibbleswap.js';
import nibbleswapSpecMod from '../specs/nibbleswapSpec.js';
import corpusCodecMod from '../corpus/corpusCodec.js';

function checkNibbleswap() {
  const spec = nibbleswapSpecMod.nibbleswapSpec();
  for (const text of corpusCodecMod.corpusCodec()) {
    const packed = nibbleswap.nibbleswapEncode(text);
    if (nibbleswap.nibbleswapDecode(packed) !== text) return false;
  }
  return spec.category === 'codec';
}

export default { checkNibbleswap };
