// Test parameters for the xorkey family.
export interface XorkeySpecShape {
  name: string;
  category: string;
  key: number;
}

export class XorkeySpec {
  static get(): XorkeySpecShape {
    return { name: 'xorkey', category: 'mask', key: 17 };
  }

  static notes(): string {
    return 'xor archetype, fixture key 17';
  }
}
