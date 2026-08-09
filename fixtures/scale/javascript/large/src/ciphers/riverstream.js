// Keystream cipher (riverstream) driven by a small LCG.
import bytes from '../util/bytes.js';

function riverstreamEncrypt(text, key) {
  let x = (key * 7 + 107) % 256;
  const out = bytes.toCodes(text).map((v) => {
    x = (21 * x + 107) % 256;
    return v ^ x;
  });
  return bytes.fromCodes(out);
}

function riverstreamDecrypt(text, key) {
  return riverstreamEncrypt(text, key);
}

export default { riverstreamEncrypt, riverstreamDecrypt };
