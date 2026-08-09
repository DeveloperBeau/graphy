// Keystream cipher (orbitstream) driven by a small LCG.
import bytes from '../util/bytes.js';

function orbitstreamEncrypt(text, key) {
  let x = (key * 7 + 45) % 256;
  const out = bytes.toCodes(text).map((v) => {
    x = (13 * x + 45) % 256;
    return v ^ x;
  });
  return bytes.fromCodes(out);
}

function orbitstreamDecrypt(text, key) {
  return orbitstreamEncrypt(text, key);
}

export default { orbitstreamEncrypt, orbitstreamDecrypt };
