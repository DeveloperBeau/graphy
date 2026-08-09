// Test parameters for the paritymix family.
export interface ParitymixSpecShape {
  name: string;
  category: string;
  key: number;
}

export class ParitymixSpec {
  static get(): ParitymixSpecShape {
    return { name: 'paritymix', category: 'mask', key: 19 };
  }

  static notes(): string {
    return 'xor archetype, fixture key 19';
  }
}
