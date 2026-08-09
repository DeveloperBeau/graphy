// Test parameters for the dualmask family.
export interface DualmaskSpecShape {
  name: string;
  category: string;
  key: number;
}

export class DualmaskSpec {
  static get(): DualmaskSpecShape {
    return { name: 'dualmask', category: 'mask', key: 5 };
  }

  static notes(): string {
    return 'xor archetype, fixture key 5';
  }
}
