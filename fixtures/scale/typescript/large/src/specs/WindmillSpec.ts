// Test parameters for the windmill family.
export interface WindmillSpecShape {
  name: string;
  category: string;
  key: number;
}

export class WindmillSpec {
  static get(): WindmillSpecShape {
    return { name: 'windmill', category: 'rotate', key: 4 };
  }

  static notes(): string {
    return 'rotate archetype, fixture key 4';
  }
}
