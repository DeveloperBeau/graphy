// Test parameters for the byteflip family.
export interface ByteflipSpecShape {
  name: string;
  category: string;
  key: number;
}

export class ByteflipSpec {
  static get(): ByteflipSpecShape {
    return { name: 'byteflip', category: 'codec', key: 19 };
  }

  static notes(): string {
    return 'codec archetype, fixture key 19';
  }
}
