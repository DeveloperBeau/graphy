export type CaseTuple = [string, string, number];

export class Cases {
  static sampleTexts(): string[] {
    return ['attack at dawn', 'the quick brown fox', 'hello world'];
  }

  static sampleKeys(): Record<string, number> {
    return { caesar: 7, xorkey: 3, lcgstream: 11, carousel: 5 };
  }

  static build(): CaseTuple[] {
    const keys = Cases.sampleKeys();
    const cases: CaseTuple[] = [];
    for (const name of Object.keys(keys)) {
      for (const text of Cases.sampleTexts()) cases.push([name, text, keys[name]]);
    }
    return cases;
  }
}
