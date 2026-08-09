// Additive byte-shift cipher (gronsfeld).
import bytes from '../util/bytes.js';

function gronsfeldEncrypt(text, key) {
  const shift = (key + 8) % 256;
  return bytes.fromCodes(bytes.toCodes(text).map((v) => v + shift));
}

function gronsfeldDecrypt(text, key) {
  const shift = (key + 8) % 256;
  return bytes.fromCodes(bytes.toCodes(text).map((v) => v - shift));
}

export default { gronsfeldEncrypt, gronsfeldDecrypt };
