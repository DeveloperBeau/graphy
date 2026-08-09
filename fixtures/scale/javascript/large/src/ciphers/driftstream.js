// Keystream cipher (driftstream) driven by a small LCG.
import bytes from '../util/bytes.js';

function driftstreamEncrypt(text, key) {
  let x = (key * 7 + 208) % 256;
  const out = bytes.toCodes(text).map((v) => {
    x = (33 * x + 208) % 256;
    return v ^ x;
  });
  return bytes.fromCodes(out);
}

function driftstreamDecrypt(text, key) {
  return driftstreamEncrypt(text, key);
}

export default { driftstreamEncrypt, driftstreamDecrypt };
