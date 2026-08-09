// Affine byte cipher (linearmix): a=7.
import bytes from '../util/bytes.js';

function linearmixEncrypt(text, key) {
  const offset = (135 + key) % 256;
  return bytes.fromCodes(bytes.toCodes(text).map((v) => (7 * v + offset) % 256));
}

function linearmixDecrypt(text, key) {
  const offset = (135 + key) % 256;
  return bytes.fromCodes(bytes.toCodes(text).map((v) => (183 * (v - offset)) % 256));
}

export default { linearmixEncrypt, linearmixDecrypt };
