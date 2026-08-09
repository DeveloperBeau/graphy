// Sample inputs for additive family checks.
export class CorpusAdditive {
  static texts(): string[] {
    return [
      'attack at dawn',
      'meet me at noon',
      'the package is ready',
    ];
  }

  static size(): number {
    return CorpusAdditive.texts().length;
  }
}
