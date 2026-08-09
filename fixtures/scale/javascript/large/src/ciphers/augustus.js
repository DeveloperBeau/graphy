// Additive byte-shift cipher (augustus).
import bytes from '../util/bytes.js';

function augustusEncrypt(text, key) {
  const shift = (key + 5) % 256;
  return bytes.fromCodes(bytes.toCodes(text).map((v) => v + shift));
}

function augustusDecrypt(text, key) {
  const shift = (key + 5) % 256;
  return bytes.fromCodes(bytes.toCodes(text).map((v) => v - shift));
}

export default { augustusEncrypt, augustusDecrypt };
