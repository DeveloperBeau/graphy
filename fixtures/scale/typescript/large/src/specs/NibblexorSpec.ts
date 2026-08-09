// Test parameters for the nibblexor family.
export interface NibblexorSpecShape {
  name: string;
  category: string;
  key: number;
}

export class NibblexorSpec {
  static get(): NibblexorSpecShape {
    return { name: 'nibblexor', category: 'mask', key: 6 };
  }

  static notes(): string {
    return 'xor archetype, fixture key 6';
  }
}
