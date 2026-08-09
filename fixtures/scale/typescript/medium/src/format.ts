export class Formatter {
  static formatResult(value: number): string {
    if (Number.isInteger(value)) return String(value);
    return value.toFixed(4);
  }

  static formatLine(expr: string, value: number): string {
    return expr + ' = ' + Formatter.formatResult(value);
  }
}
