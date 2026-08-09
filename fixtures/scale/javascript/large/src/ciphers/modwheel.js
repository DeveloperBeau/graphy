// Affine byte cipher (modwheel): a=5.
import bytes from '../util/bytes.js';

function modwheelEncrypt(text, key) {
  const offset = (124 + key) % 256;
  return bytes.fromCodes(bytes.toCodes(text).map((v) => (5 * v + offset) % 256));
}

function modwheelDecrypt(text, key) {
  const offset = (124 + key) % 256;
  return bytes.fromCodes(bytes.toCodes(text).map((v) => (205 * (v - offset)) % 256));
}

export default { modwheelEncrypt, modwheelDecrypt };
