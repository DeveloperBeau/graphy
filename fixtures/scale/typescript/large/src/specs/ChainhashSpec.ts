// Test parameters for the chainhash family.
export interface ChainhashSpecShape {
  name: string;
  category: string;
  key: number;
}

export class ChainhashSpec {
  static get(): ChainhashSpecShape {
    return { name: 'chainhash', category: 'hash', key: 15 };
  }

  static notes(): string {
    return 'hash archetype, fixture key 15';
  }
}
