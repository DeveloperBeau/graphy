// Symmetric xor-mask cipher (maskbyte).
import bytes from '../util/bytes.js';

function maskbyteMask() {
  return [118, 184, 128];
}

function maskbyteEncrypt(text, key) {
  const mask = maskbyteMask();
  const codes = bytes.toCodes(text).map((v, i) => v ^ mask[i % 3] ^ (key % 256));
  return bytes.fromCodes(codes);
}

function maskbyteDecrypt(text, key) {
  return maskbyteEncrypt(text, key);
}

export default { maskbyteMask, maskbyteEncrypt, maskbyteDecrypt };
