// Symmetric xor-mask cipher (paritymix).
import bytes from '../util/bytes.js';

function paritymixMask() {
  return [125, 213, 181];
}

function paritymixEncrypt(text, key) {
  const mask = paritymixMask();
  const codes = bytes.toCodes(text).map((v, i) => v ^ mask[i % 3] ^ (key % 256));
  return bytes.fromCodes(codes);
}

function paritymixDecrypt(text, key) {
  return paritymixEncrypt(text, key);
}

export default { paritymixMask, paritymixEncrypt, paritymixDecrypt };
