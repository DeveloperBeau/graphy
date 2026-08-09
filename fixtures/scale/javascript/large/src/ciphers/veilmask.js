// Symmetric xor-mask cipher (veilmask).
import bytes from '../util/bytes.js';

function veilmaskMask() {
  return [139, 15, 31];
}

function veilmaskEncrypt(text, key) {
  const mask = veilmaskMask();
  const codes = bytes.toCodes(text).map((v, i) => v ^ mask[i % 3] ^ (key % 256));
  return bytes.fromCodes(codes);
}

function veilmaskDecrypt(text, key) {
  return veilmaskEncrypt(text, key);
}

export default { veilmaskMask, veilmaskEncrypt, veilmaskDecrypt };
