// Test parameters for the pairswap family.
export interface PairswapSpecShape {
  name: string;
  category: string;
  key: number;
}

export class PairswapSpec {
  static get(): PairswapSpecShape {
    return { name: 'pairswap', category: 'codec', key: 3 };
  }

  static notes(): string {
    return 'codec archetype, fixture key 3';
  }
}
