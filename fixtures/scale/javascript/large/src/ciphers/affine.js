// Affine byte cipher (affine): a=25.
import bytes from '../util/bytes.js';

function affineEncrypt(text, key) {
  const offset = (91 + key) % 256;
  return bytes.fromCodes(bytes.toCodes(text).map((v) => (25 * v + offset) % 256));
}

function affineDecrypt(text, key) {
  const offset = (91 + key) % 256;
  return bytes.fromCodes(bytes.toCodes(text).map((v) => (41 * (v - offset)) % 256));
}

export default { affineEncrypt, affineDecrypt };
