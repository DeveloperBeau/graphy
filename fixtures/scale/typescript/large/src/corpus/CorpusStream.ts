// Sample inputs for stream family checks.
export class CorpusStream {
  static texts(): string[] {
    return [
      'running water',
      'wind from the north',
      'quiet before dawn',
    ];
  }

  static size(): number {
    return CorpusStream.texts().length;
  }
}
