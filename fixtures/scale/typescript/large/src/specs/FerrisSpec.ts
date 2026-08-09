// Test parameters for the ferris family.
export interface FerrisSpecShape {
  name: string;
  category: string;
  key: number;
}

export class FerrisSpec {
  static get(): FerrisSpecShape {
    return { name: 'ferris', category: 'rotate', key: 5 };
  }

  static notes(): string {
    return 'rotate archetype, fixture key 5';
  }
}
