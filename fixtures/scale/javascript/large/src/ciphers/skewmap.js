// Affine byte cipher (skewmap): a=9.
import bytes from '../util/bytes.js';

function skewmapEncrypt(text, key) {
  const offset = (146 + key) % 256;
  return bytes.fromCodes(bytes.toCodes(text).map((v) => (9 * v + offset) % 256));
}

function skewmapDecrypt(text, key) {
  const offset = (146 + key) % 256;
  return bytes.fromCodes(bytes.toCodes(text).map((v) => (57 * (v - offset)) % 256));
}

export default { skewmapEncrypt, skewmapDecrypt };
