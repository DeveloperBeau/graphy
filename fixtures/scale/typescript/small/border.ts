import { Theme } from './theme';

export class Border {
  static top(width: number, name: string): string {
    const chars = Theme.chars(name);
    return chars.corner + chars.edge.repeat(width) + chars.corner;
  }

  static side(line: string, width: number, name: string): string {
    const chars = Theme.chars(name);
    return chars.side + line.padEnd(width) + chars.side;
  }
}
