// feature: class, generator function, async function

export class State {
    constructor() {
        this.value = "idle";
    }
}

export class Greeter {
    hi() {
        return "hello";
    }
}

export function* idGenerator() {
    let id = 0;
    while (true) {
        yield id++;
    }
}

export async function fetchData(url) {
    return url;
}
