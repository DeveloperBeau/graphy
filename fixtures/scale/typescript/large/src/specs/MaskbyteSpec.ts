// Test parameters for the maskbyte family.
export interface MaskbyteSpecShape {
  name: string;
  category: string;
  key: number;
}

export class MaskbyteSpec {
  static get(): MaskbyteSpecShape {
    return { name: 'maskbyte', category: 'mask', key: 18 };
  }

  static notes(): string {
    return 'xor archetype, fixture key 18';
  }
}
