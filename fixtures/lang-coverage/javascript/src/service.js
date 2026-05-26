// feature: class extends, import styles (named, default, namespace, aliased),
//          cross-file call, external call (console.log must not produce local edge)

import { formatName } from "./helpers.js";
import { Greeter } from "./types.js";
import { State as AppState } from "./types.js";
import * as helpers from "./helpers.js";

export default class Service extends Greeter {
    #cache;

    constructor(name) {
        super();
        this.name = name;
        this.#cache = new Map();
    }

    hi() {
        return "hello from " + this.name;
    }

    run() {
        const greeting = formatName(this.name);
        console.log(greeting);
        const s = new AppState();
        helpers.unrelatedHelper();
    }
}
