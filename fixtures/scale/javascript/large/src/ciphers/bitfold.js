// Symmetric xor-mask cipher (bitfold).
import bytes from '../util/bytes.js';

function bitfoldMask() {
  return [132, 242, 234];
}

function bitfoldEncrypt(text, key) {
  const mask = bitfoldMask();
  const codes = bytes.toCodes(text).map((v, i) => v ^ mask[i % 3] ^ (key % 256));
  return bytes.fromCodes(codes);
}

function bitfoldDecrypt(text, key) {
  return bitfoldEncrypt(text, key);
}

export default { bitfoldMask, bitfoldEncrypt, bitfoldDecrypt };
