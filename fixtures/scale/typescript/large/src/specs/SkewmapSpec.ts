// Test parameters for the skewmap family.
export interface SkewmapSpecShape {
  name: string;
  category: string;
  key: number;
}

export class SkewmapSpec {
  static get(): SkewmapSpecShape {
    return { name: 'skewmap', category: 'affine', key: 16 };
  }

  static notes(): string {
    return 'affine archetype, fixture key 16';
  }
}
