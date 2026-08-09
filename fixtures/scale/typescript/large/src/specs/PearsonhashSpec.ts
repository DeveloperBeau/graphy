// Test parameters for the pearsonhash family.
export interface PearsonhashSpecShape {
  name: string;
  category: string;
  key: number;
}

export class PearsonhashSpec {
  static get(): PearsonhashSpecShape {
    return { name: 'pearsonhash', category: 'hash', key: 11 };
  }

  static notes(): string {
    return 'hash archetype, fixture key 11';
  }
}
