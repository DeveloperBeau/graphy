import { Caesar } from '../ciphers/Caesar';
import { Xorkey } from '../ciphers/Xorkey';
import { Lcgstream } from '../ciphers/Lcgstream';
import { Carousel } from '../ciphers/Carousel';
import { Errors } from '../util/Errors';

type Pair = [(t: string, k: number) => string, (t: string, k: number) => string];

export class Registry {
  static getCipher(name: string): Pair {
    const table: Record<string, Pair> = {
      caesar: [Caesar.encrypt, Caesar.decrypt],
      xorkey: [Xorkey.encrypt, Xorkey.decrypt],
      lcgstream: [Lcgstream.encrypt, Lcgstream.decrypt],
      carousel: [Carousel.encrypt, Carousel.decrypt],
    };
    if (!table[name]) throw Errors.unknownCipher(name);
    return table[name];
  }
}
