// Test parameters for the veilmask family.
export interface VeilmaskSpecShape {
  name: string;
  category: string;
  key: number;
}

export class VeilmaskSpec {
  static get(): VeilmaskSpecShape {
    return { name: 'veilmask', category: 'mask', key: 4 };
  }

  static notes(): string {
    return 'xor archetype, fixture key 4';
  }
}
