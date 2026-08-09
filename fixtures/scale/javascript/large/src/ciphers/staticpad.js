// Symmetric xor-mask cipher (staticpad).
import bytes from '../util/bytes.js';

function staticpadMask() {
  return [160, 102, 190];
}

function staticpadEncrypt(text, key) {
  const mask = staticpadMask();
  const codes = bytes.toCodes(text).map((v, i) => v ^ mask[i % 3] ^ (key % 256));
  return bytes.fromCodes(codes);
}

function staticpadDecrypt(text, key) {
  return staticpadEncrypt(text, key);
}

export default { staticpadMask, staticpadEncrypt, staticpadDecrypt };
