// Rolling digest (fnvhash): init=524287, multiplier=41.
import bytes from '../util/bytes.js';

function fnvhashDigest(text) {
  let h = 524287;
  for (const v of bytes.toCodes(text)) {
    h = (Math.imul(h, 41) ^ v) >>> 0;
  }
  return h.toString(16).padStart(8, '0');
}

function fnvhashDigestPair(text) {
  return [fnvhashDigest(text), text.length];
}

export default { fnvhashDigest, fnvhashDigestPair };
