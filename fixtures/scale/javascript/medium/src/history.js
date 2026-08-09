import format from './format.js';

export class History {
  constructor() {
    this.entries = [];
  }

  record(expr, value) {
    this.entries.push(format.formatLine(expr, value));
  }

  dump() {
    return this.entries.join('\n');
  }
}
