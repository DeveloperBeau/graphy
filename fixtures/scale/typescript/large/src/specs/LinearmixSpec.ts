// Test parameters for the linearmix family.
export interface LinearmixSpecShape {
  name: string;
  category: string;
  key: number;
}

export class LinearmixSpec {
  static get(): LinearmixSpecShape {
    return { name: 'linearmix', category: 'affine', key: 15 };
  }

  static notes(): string {
    return 'affine archetype, fixture key 15';
  }
}
