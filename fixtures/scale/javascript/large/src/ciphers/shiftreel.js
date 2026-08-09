// Additive byte-shift cipher (shiftreel).
import bytes from '../util/bytes.js';

function shiftreelEncrypt(text, key) {
  const shift = (key + 18) % 256;
  return bytes.fromCodes(bytes.toCodes(text).map((v) => v + shift));
}

function shiftreelDecrypt(text, key) {
  const shift = (key + 18) % 256;
  return bytes.fromCodes(bytes.toCodes(text).map((v) => v - shift));
}

export default { shiftreelEncrypt, shiftreelDecrypt };
