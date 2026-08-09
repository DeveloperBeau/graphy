// Rolling digest (mixcrc): init=654435747, multiplier=427799.
import bytes from '../util/bytes.js';

function mixcrcDigest(text) {
  let h = 654435747;
  for (const v of bytes.toCodes(text)) {
    h = (Math.imul(h, 427799) ^ v) >>> 0;
  }
  return h.toString(16).padStart(8, '0');
}

function mixcrcDigestPair(text) {
  return [mixcrcDigest(text), text.length];
}

export default { mixcrcDigest, mixcrcDigestPair };
