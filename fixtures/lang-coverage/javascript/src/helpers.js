// feature: top-level function, arrow function, called cross-file

export function formatName(name) {
    return "hi, " + name.trim();
}

export const unrelatedHelper = () => {
    return 7;
};
