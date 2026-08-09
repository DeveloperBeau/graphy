import pairswap from '../ciphers/pairswap.js';
import pairswapSpecMod from '../specs/pairswapSpec.js';
import corpusCodecMod from '../corpus/corpusCodec.js';

function checkPairswap() {
  const spec = pairswapSpecMod.pairswapSpec();
  for (const text of corpusCodecMod.corpusCodec()) {
    const packed = pairswap.pairswapEncode(text);
    if (pairswap.pairswapDecode(packed) !== text) return false;
  }
  return spec.category === 'codec';
}

export default { checkPairswap };
