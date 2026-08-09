// Keystream cipher (emberstream) driven by a small LCG.
import bytes from '../util/bytes.js';

function emberstreamEncrypt(text, key) {
  let x = (key * 7 + 76) % 256;
  const out = bytes.toCodes(text).map((v) => {
    x = (17 * x + 76) % 256;
    return v ^ x;
  });
  return bytes.fromCodes(out);
}

function emberstreamDecrypt(text, key) {
  return emberstreamEncrypt(text, key);
}

export default { emberstreamEncrypt, emberstreamDecrypt };
