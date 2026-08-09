// Symmetric xor-mask cipher (xorkey).
import bytes from '../util/bytes.js';

function xorkeyMask() {
  return [111, 155, 75];
}

function xorkeyEncrypt(text, key) {
  const mask = xorkeyMask();
  const codes = bytes.toCodes(text).map((v, i) => v ^ mask[i % 3] ^ (key % 256));
  return bytes.fromCodes(codes);
}

function xorkeyDecrypt(text, key) {
  return xorkeyEncrypt(text, key);
}

export default { xorkeyMask, xorkeyEncrypt, xorkeyDecrypt };
