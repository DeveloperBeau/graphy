// Test parameters for the blockrotate family.
export interface BlockrotateSpecShape {
  name: string;
  category: string;
  key: number;
}

export class BlockrotateSpec {
  static get(): BlockrotateSpecShape {
    return { name: 'blockrotate', category: 'rotate', key: 16 };
  }

  static notes(): string {
    return 'rotate archetype, fixture key 16';
  }
}
