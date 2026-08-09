// Sample inputs for rotate family checks.
export class CorpusRotate {
  static texts(): string[] {
    return [
      'turn the wheel',
      'round and round',
      'clockwise once more',
    ];
  }

  static size(): number {
    return CorpusRotate.texts().length;
  }
}
