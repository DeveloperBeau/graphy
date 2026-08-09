// Rolling digest (chainhash): init=131, multiplier=131.
import bytes from '../util/bytes.js';

function chainhashDigest(text) {
  let h = 131;
  for (const v of bytes.toCodes(text)) {
    h = (Math.imul(h, 131) ^ v) >>> 0;
  }
  return h.toString(16).padStart(8, '0');
}

function chainhashDigestPair(text) {
  return [chainhashDigest(text), text.length];
}

export default { chainhashDigest, chainhashDigestPair };
