// Symmetric xor-mask cipher (nibblexor).
import bytes from '../util/bytes.js';

function nibblexorMask() {
  return [153, 73, 137];
}

function nibblexorEncrypt(text, key) {
  const mask = nibblexorMask();
  const codes = bytes.toCodes(text).map((v, i) => v ^ mask[i % 3] ^ (key % 256));
  return bytes.fromCodes(codes);
}

function nibblexorDecrypt(text, key) {
  return nibblexorEncrypt(text, key);
}

export default { nibblexorMask, nibblexorEncrypt, nibblexorDecrypt };
