// Test parameters for the mirrorpack family.
export interface MirrorpackSpecShape {
  name: string;
  category: string;
  key: number;
}

export class MirrorpackSpec {
  static get(): MirrorpackSpecShape {
    return { name: 'mirrorpack', category: 'codec', key: 4 };
  }

  static notes(): string {
    return 'codec archetype, fixture key 4';
  }
}
