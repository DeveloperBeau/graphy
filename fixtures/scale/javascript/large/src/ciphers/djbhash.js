// Rolling digest (djbhash): init=131071, multiplier=43.
import bytes from '../util/bytes.js';

function djbhashDigest(text) {
  let h = 131071;
  for (const v of bytes.toCodes(text)) {
    h = (Math.imul(h, 43) ^ v) >>> 0;
  }
  return h.toString(16).padStart(8, '0');
}

function djbhashDigestPair(text) {
  return [djbhashDigest(text), text.length];
}

export default { djbhashDigest, djbhashDigestPair };
