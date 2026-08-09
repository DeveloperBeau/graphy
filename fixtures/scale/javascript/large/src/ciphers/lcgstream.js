// Keystream cipher (lcgstream) driven by a small LCG.
import bytes from '../util/bytes.js';

function lcgstreamEncrypt(text, key) {
  let x = (key * 7 + 177) % 256;
  const out = bytes.toCodes(text).map((v) => {
    x = (29 * x + 177) % 256;
    return v ^ x;
  });
  return bytes.fromCodes(out);
}

function lcgstreamDecrypt(text, key) {
  return lcgstreamEncrypt(text, key);
}

export default { lcgstreamEncrypt, lcgstreamDecrypt };
