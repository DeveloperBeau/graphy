// Rolling digest (jenkinshash): init=5381, multiplier=33.
import bytes from '../util/bytes.js';

function jenkinshashDigest(text) {
  let h = 5381;
  for (const v of bytes.toCodes(text)) {
    h = (Math.imul(h, 33) ^ v) >>> 0;
  }
  return h.toString(16).padStart(8, '0');
}

function jenkinshashDigestPair(text) {
  return [jenkinshashDigest(text), text.length];
}

export default { jenkinshashDigest, jenkinshashDigestPair };
