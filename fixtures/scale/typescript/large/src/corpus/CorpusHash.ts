// Sample inputs for hash family checks.
export class CorpusHash {
  static texts(): string[] {
    return [
      'checksum this line',
      'integrity matters',
      'verify everything twice',
    ];
  }

  static size(): number {
    return CorpusHash.texts().length;
  }
}
