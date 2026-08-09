// Test parameters for the ordinal family.
export interface OrdinalSpecShape {
  name: string;
  category: string;
  key: number;
}

export class OrdinalSpec {
  static get(): OrdinalSpecShape {
    return { name: 'ordinal', category: 'additive', key: 10 };
  }

  static notes(): string {
    return 'shift archetype, fixture key 10';
  }
}
