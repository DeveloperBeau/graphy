import { Carousel } from '../ciphers/Carousel';
import { CarouselSpec } from '../specs/CarouselSpec';
import { CorpusRotate } from '../corpus/CorpusRotate';

export class CheckCarousel {
  static run(): boolean {
    const spec = CarouselSpec.get();
    for (const text of CorpusRotate.texts()) {
      const sealed = Carousel.encrypt(text, spec.key);
      const opened = Carousel.decrypt(sealed, spec.key);
      if (opened !== text) return false;
    }
    return spec.category === 'rotate';
  }
}
