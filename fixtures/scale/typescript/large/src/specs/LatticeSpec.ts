// Test parameters for the lattice family.
export interface LatticeSpecShape {
  name: string;
  category: string;
  key: number;
}

export class LatticeSpec {
  static get(): LatticeSpecShape {
    return { name: 'lattice', category: 'rotate', key: 6 };
  }

  static notes(): string {
    return 'rotate archetype, fixture key 6';
  }
}
