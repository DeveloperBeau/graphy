// Test parameters for the hexpack family.
export interface HexpackSpecShape {
  name: string;
  category: string;
  key: number;
}

export class HexpackSpec {
  static get(): HexpackSpecShape {
    return { name: 'hexpack', category: 'codec', key: 17 };
  }

  static notes(): string {
    return 'codec archetype, fixture key 17';
  }
}
