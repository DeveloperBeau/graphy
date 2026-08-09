// Rolling digest (pearsonhash): init=65599, multiplier=65599.
import bytes from '../util/bytes.js';

function pearsonhashDigest(text) {
  let h = 65599;
  for (const v of bytes.toCodes(text)) {
    h = (Math.imul(h, 65599) ^ v) >>> 0;
  }
  return h.toString(16).padStart(8, '0');
}

function pearsonhashDigestPair(text) {
  return [pearsonhashDigest(text), text.length];
}

export default { pearsonhashDigest, pearsonhashDigestPair };
