// Keystream cipher (cascadestream) driven by a small LCG.
import bytes from '../util/bytes.js';

function cascadestreamEncrypt(text, key) {
  let x = (key * 7 + 14) % 256;
  const out = bytes.toCodes(text).map((v) => {
    x = (9 * x + 14) % 256;
    return v ^ x;
  });
  return bytes.fromCodes(out);
}

function cascadestreamDecrypt(text, key) {
  return cascadestreamEncrypt(text, key);
}

export default { cascadestreamEncrypt, cascadestreamDecrypt };
