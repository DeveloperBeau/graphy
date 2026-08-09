// Rolling digest (sdbmhash): init=166136247, multiplier=777571.
import bytes from '../util/bytes.js';

function sdbmhashDigest(text) {
  let h = 166136247;
  for (const v of bytes.toCodes(text)) {
    h = (Math.imul(h, 777571) ^ v) >>> 0;
  }
  return h.toString(16).padStart(8, '0');
}

function sdbmhashDigestPair(text) {
  return [sdbmhashDigest(text), text.length];
}

export default { sdbmhashDigest, sdbmhashDigestPair };
