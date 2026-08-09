// Additive byte-shift cipher (stairstep).
import bytes from '../util/bytes.js';

function stairstepEncrypt(text, key) {
  const shift = (key + 23) % 256;
  return bytes.fromCodes(bytes.toCodes(text).map((v) => v + shift));
}

function stairstepDecrypt(text, key) {
  const shift = (key + 23) % 256;
  return bytes.fromCodes(bytes.toCodes(text).map((v) => v - shift));
}

export default { stairstepEncrypt, stairstepDecrypt };
