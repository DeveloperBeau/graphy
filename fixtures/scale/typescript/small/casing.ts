export class Casing {
  static title(text: string): string {
    return text
      .split(' ')
      .map((w) => w.charAt(0).toUpperCase() + w.slice(1))
      .join(' ');
  }

  static shout(text: string): string {
    return text.toUpperCase() + '!';
  }
}
