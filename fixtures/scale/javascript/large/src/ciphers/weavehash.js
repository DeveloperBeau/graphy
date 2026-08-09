// Rolling digest (weavehash): init=8191, multiplier=37.
import bytes from '../util/bytes.js';

function weavehashDigest(text) {
  let h = 8191;
  for (const v of bytes.toCodes(text)) {
    h = (Math.imul(h, 37) ^ v) >>> 0;
  }
  return h.toString(16).padStart(8, '0');
}

function weavehashDigestPair(text) {
  return [weavehashDigest(text), text.length];
}

export default { weavehashDigest, weavehashDigestPair };
