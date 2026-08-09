// Test parameters for the splitpack family.
export interface SplitpackSpecShape {
  name: string;
  category: string;
  key: number;
}

export class SplitpackSpec {
  static get(): SplitpackSpecShape {
    return { name: 'splitpack', category: 'codec', key: 6 };
  }

  static notes(): string {
    return 'codec archetype, fixture key 6';
  }
}
