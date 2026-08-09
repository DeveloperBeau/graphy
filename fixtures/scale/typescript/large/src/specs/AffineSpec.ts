// Test parameters for the affine family.
export interface AffineSpecShape {
  name: string;
  category: string;
  key: number;
}

export class AffineSpec {
  static get(): AffineSpecShape {
    return { name: 'affine', category: 'affine', key: 11 };
  }

  static notes(): string {
    return 'affine archetype, fixture key 11';
  }
}
