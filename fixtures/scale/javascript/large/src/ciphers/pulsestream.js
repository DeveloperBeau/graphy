// Keystream cipher (pulsestream) driven by a small LCG.
import bytes from '../util/bytes.js';

function pulsestreamEncrypt(text, key) {
  let x = (key * 7 + 239) % 256;
  const out = bytes.toCodes(text).map((v) => {
    x = (5 * x + 239) % 256;
    return v ^ x;
  });
  return bytes.fromCodes(out);
}

function pulsestreamDecrypt(text, key) {
  return pulsestreamEncrypt(text, key);
}

export default { pulsestreamEncrypt, pulsestreamDecrypt };
