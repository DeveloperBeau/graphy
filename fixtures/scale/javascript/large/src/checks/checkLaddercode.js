import laddercode from '../ciphers/laddercode.js';
import laddercodeSpecMod from '../specs/laddercodeSpec.js';
import corpusCodecMod from '../corpus/corpusCodec.js';

function checkLaddercode() {
  const spec = laddercodeSpecMod.laddercodeSpec();
  for (const text of corpusCodecMod.corpusCodec()) {
    const packed = laddercode.laddercodeEncode(text);
    if (laddercode.laddercodeDecode(packed) !== text) return false;
  }
  return spec.category === 'codec';
}

export default { checkLaddercode };
