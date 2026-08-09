// Additive byte-shift cipher (caesar).
import bytes from '../util/bytes.js';

function caesarEncrypt(text, key) {
  const shift = (key + 3) % 256;
  return bytes.fromCodes(bytes.toCodes(text).map((v) => v + shift));
}

function caesarDecrypt(text, key) {
  const shift = (key + 3) % 256;
  return bytes.fromCodes(bytes.toCodes(text).map((v) => v - shift));
}

export default { caesarEncrypt, caesarDecrypt };
