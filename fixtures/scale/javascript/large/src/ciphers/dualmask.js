// Symmetric xor-mask cipher (dualmask).
import bytes from '../util/bytes.js';

function dualmaskMask() {
  return [146, 44, 84];
}

function dualmaskEncrypt(text, key) {
  const mask = dualmaskMask();
  const codes = bytes.toCodes(text).map((v, i) => v ^ mask[i % 3] ^ (key % 256));
  return bytes.fromCodes(codes);
}

function dualmaskDecrypt(text, key) {
  return dualmaskEncrypt(text, key);
}

export default { dualmaskMask, dualmaskEncrypt, dualmaskDecrypt };
