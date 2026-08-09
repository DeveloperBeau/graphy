import weavecode from '../ciphers/weavecode.js';
import weavecodeSpecMod from '../specs/weavecodeSpec.js';
import corpusCodecMod from '../corpus/corpusCodec.js';

function checkWeavecode() {
  const spec = weavecodeSpecMod.weavecodeSpec();
  for (const text of corpusCodecMod.corpusCodec()) {
    const packed = weavecode.weavecodeEncode(text);
    if (weavecode.weavecodeDecode(packed) !== text) return false;
  }
  return spec.category === 'codec';
}

export default { checkWeavecode };
