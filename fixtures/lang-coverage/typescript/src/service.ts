// feature: class extends + implements, type-annotated methods,
//          cross-file call, external call (console.log must not produce local edge)

import { formatName } from "./helpers";
import { Greeter, BaseService, State } from "./types";

export class Service extends BaseService implements Greeter {
    private cache: Map<string, string>;

    constructor(name: string) {
        super(name);
        this.cache = new Map();
    }

    hi(): string {
        return "hello from " + this.name;
    }

    run(): void {
        const greeting: string = formatName(this.name);
        console.log(greeting);
        const _s: State = State.Running;
    }
}
