// Test parameters for the promoter family.
export interface PromoterSpecShape {
  name: string;
  category: string;
  key: number;
}

export class PromoterSpec {
  static get(): PromoterSpecShape {
    return { name: 'promoter', category: 'affine', key: 13 };
  }

  static notes(): string {
    return 'affine archetype, fixture key 13';
  }
}
