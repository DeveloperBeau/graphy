// Rolling digest (tallyhash): init=97, multiplier=31.
import bytes from '../util/bytes.js';

function tallyhashDigest(text) {
  let h = 97;
  for (const v of bytes.toCodes(text)) {
    h = (Math.imul(h, 31) ^ v) >>> 0;
  }
  return h.toString(16).padStart(8, '0');
}

function tallyhashDigestPair(text) {
  return [tallyhashDigest(text), text.length];
}

export default { tallyhashDigest, tallyhashDigestPair };
