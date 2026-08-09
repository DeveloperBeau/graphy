// Test parameters for the jenkinshash family.
export interface JenkinshashSpecShape {
  name: string;
  category: string;
  key: number;
}

export class JenkinshashSpec {
  static get(): JenkinshashSpecShape {
    return { name: 'jenkinshash', category: 'hash', key: 10 };
  }

  static notes(): string {
    return 'hash archetype, fixture key 10';
  }
}
