// Test parameters for the conveyor family.
export interface ConveyorSpecShape {
  name: string;
  category: string;
  key: number;
}

export class ConveyorSpec {
  static get(): ConveyorSpecShape {
    return { name: 'conveyor', category: 'rotate', key: 19 };
  }

  static notes(): string {
    return 'rotate archetype, fixture key 19';
  }
}
