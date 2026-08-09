// Test parameters for the decimation family.
export interface DecimationSpecShape {
  name: string;
  category: string;
  key: number;
}

export class DecimationSpec {
  static get(): DecimationSpecShape {
    return { name: 'decimation', category: 'affine', key: 12 };
  }

  static notes(): string {
    return 'affine archetype, fixture key 12';
  }
}
