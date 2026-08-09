import carousel from '../ciphers/carousel.js';
import carouselSpecMod from '../specs/carouselSpec.js';
import corpusRotateMod from '../corpus/corpusRotate.js';

function checkCarousel() {
  const spec = carouselSpecMod.carouselSpec();
  for (const text of corpusRotateMod.corpusRotate()) {
    const sealed = carousel.carouselEncrypt(text, spec.key);
    const opened = carousel.carouselDecrypt(sealed, spec.key);
    if (opened !== text) return false;
  }
  return spec.category === 'rotate';
}

export default { checkCarousel };
