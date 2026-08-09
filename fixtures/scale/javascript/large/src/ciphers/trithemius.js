// Additive byte-shift cipher (trithemius).
import bytes from '../util/bytes.js';

function trithemiusEncrypt(text, key) {
  const shift = (key + 13) % 256;
  return bytes.fromCodes(bytes.toCodes(text).map((v) => v + shift));
}

function trithemiusDecrypt(text, key) {
  const shift = (key + 13) % 256;
  return bytes.fromCodes(bytes.toCodes(text).map((v) => v - shift));
}

export default { trithemiusEncrypt, trithemiusDecrypt };
