export class Timing {
  static nowMs(): number {
    return Date.now();
  }

  static elapsed(start: number): number {
    return Timing.nowMs() - start;
  }

  static formatMs(ms: number): string {
    return ms + 'ms';
  }
}
