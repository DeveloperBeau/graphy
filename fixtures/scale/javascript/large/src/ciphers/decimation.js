// Affine byte cipher (decimation): a=29.
import bytes from '../util/bytes.js';

function decimationEncrypt(text, key) {
  const offset = (102 + key) % 256;
  return bytes.fromCodes(bytes.toCodes(text).map((v) => (29 * v + offset) % 256));
}

function decimationDecrypt(text, key) {
  const offset = (102 + key) % 256;
  return bytes.fromCodes(bytes.toCodes(text).map((v) => (53 * (v - offset)) % 256));
}

export default { decimationEncrypt, decimationDecrypt };
