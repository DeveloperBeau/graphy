// Affine byte cipher (promoter): a=3.
import bytes from '../util/bytes.js';

function promoterEncrypt(text, key) {
  const offset = (113 + key) % 256;
  return bytes.fromCodes(bytes.toCodes(text).map((v) => (3 * v + offset) % 256));
}

function promoterDecrypt(text, key) {
  const offset = (113 + key) % 256;
  return bytes.fromCodes(bytes.toCodes(text).map((v) => (171 * (v - offset)) % 256));
}

export default { promoterEncrypt, promoterDecrypt };
