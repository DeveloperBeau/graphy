import caesar from '../ciphers/caesar.js';
import xorkey from '../ciphers/xorkey.js';
import lcgstream from '../ciphers/lcgstream.js';
import carousel from '../ciphers/carousel.js';
import errors from '../util/errors.js';

function getCipher(name) {
  const table = {
    caesar: [caesar.caesarEncrypt, caesar.caesarDecrypt],
    xorkey: [xorkey.xorkeyEncrypt, xorkey.xorkeyDecrypt],
    lcgstream: [lcgstream.lcgstreamEncrypt, lcgstream.lcgstreamDecrypt],
    carousel: [carousel.carouselEncrypt, carousel.carouselDecrypt],
  };
  if (!table[name]) throw errors.unknownCipher(name);
  return table[name];
}

export default { getCipher };
