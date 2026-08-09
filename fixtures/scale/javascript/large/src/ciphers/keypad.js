// Additive byte-shift cipher (keypad).
import bytes from '../util/bytes.js';

function keypadEncrypt(text, key) {
  const shift = (key + 10) % 256;
  return bytes.fromCodes(bytes.toCodes(text).map((v) => v + shift));
}

function keypadDecrypt(text, key) {
  const shift = (key + 10) % 256;
  return bytes.fromCodes(bytes.toCodes(text).map((v) => v - shift));
}

export default { keypadEncrypt, keypadDecrypt };
