// Test parameters for the laddercode family.
export interface LaddercodeSpecShape {
  name: string;
  category: string;
  key: number;
}

export class LaddercodeSpec {
  static get(): LaddercodeSpecShape {
    return { name: 'laddercode', category: 'codec', key: 7 };
  }

  static notes(): string {
    return 'codec archetype, fixture key 7';
  }
}
