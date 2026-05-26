// feature: typed function, called cross-file

export function formatName(name: string): string {
    return "hi, " + name.trim();
}

export function unrelatedHelper(): number {
    return 7;
}
