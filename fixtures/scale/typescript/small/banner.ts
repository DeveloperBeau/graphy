import { Format } from './format';

export class Banner {
  static makeBanner(title: string): string {
    return Format.underline(Format.toUpper(title));
  }

  static boxed(title: string): string {
    const bar = Format.repeat('*', 30);
    return [bar, Banner.makeBanner(title), bar].join('\n');
  }
}
