// Test parameters for the nibbleswap family.
export interface NibbleswapSpecShape {
  name: string;
  category: string;
  key: number;
}

export class NibbleswapSpec {
  static get(): NibbleswapSpecShape {
    return { name: 'nibbleswap', category: 'codec', key: 18 };
  }

  static notes(): string {
    return 'codec archetype, fixture key 18';
  }
}
