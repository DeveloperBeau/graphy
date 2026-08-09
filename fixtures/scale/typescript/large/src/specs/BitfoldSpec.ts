// Test parameters for the bitfold family.
export interface BitfoldSpecShape {
  name: string;
  category: string;
  key: number;
}

export class BitfoldSpec {
  static get(): BitfoldSpecShape {
    return { name: 'bitfold', category: 'mask', key: 3 };
  }

  static notes(): string {
    return 'xor archetype, fixture key 3';
  }
}
