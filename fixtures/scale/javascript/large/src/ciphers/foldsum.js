// Rolling digest (foldsum): init=40503, multiplier=40503.
import bytes from '../util/bytes.js';

function foldsumDigest(text) {
  let h = 40503;
  for (const v of bytes.toCodes(text)) {
    h = (Math.imul(h, 40503) ^ v) >>> 0;
  }
  return h.toString(16).padStart(8, '0');
}

function foldsumDigestPair(text) {
  return [foldsumDigest(text), text.length];
}

export default { foldsumDigest, foldsumDigestPair };
