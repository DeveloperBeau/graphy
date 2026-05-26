// feature: interface, type alias, enum, abstract class

export interface Greeter {
    hi(): string;
}

export type UserId = number;

export enum State { Idle = "idle", Running = "running", Done = "done" }

export abstract class BaseService {
    protected name: string;
    constructor(name: string) {
        this.name = name;
    }
    abstract run(): void;
}
