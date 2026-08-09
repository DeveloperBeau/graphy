// Sample inputs for codec family checks.
export class CorpusCodec {
  static texts(): string[] {
    return [
      'pack and unpack',
      'mirror the message',
      'swap every pair',
    ];
  }

  static size(): number {
    return CorpusCodec.texts().length;
  }
}
