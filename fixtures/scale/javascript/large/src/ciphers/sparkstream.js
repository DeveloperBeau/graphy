// Keystream cipher (sparkstream) driven by a small LCG.
import bytes from '../util/bytes.js';

function sparkstreamEncrypt(text, key) {
  let x = (key * 7 + 138) % 256;
  const out = bytes.toCodes(text).map((v) => {
    x = (25 * x + 138) % 256;
    return v ^ x;
  });
  return bytes.fromCodes(out);
}

function sparkstreamDecrypt(text, key) {
  return sparkstreamEncrypt(text, key);
}

export default { sparkstreamEncrypt, sparkstreamDecrypt };
