// Test parameters for the riverstream family.
export interface RiverstreamSpecShape {
  name: string;
  category: string;
  key: number;
}

export class RiverstreamSpec {
  static get(): RiverstreamSpecShape {
    return { name: 'riverstream', category: 'stream', key: 14 };
  }

  static notes(): string {
    return 'lcg archetype, fixture key 14';
  }
}
