// Additive byte-shift cipher (ordinal).
import bytes from '../util/bytes.js';

function ordinalEncrypt(text, key) {
  const shift = (key + 15) % 256;
  return bytes.fromCodes(bytes.toCodes(text).map((v) => v + shift));
}

function ordinalDecrypt(text, key) {
  const shift = (key + 15) % 256;
  return bytes.fromCodes(bytes.toCodes(text).map((v) => v - shift));
}

export default { ordinalEncrypt, ordinalDecrypt };
