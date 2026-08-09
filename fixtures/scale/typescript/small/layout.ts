import { Wrap } from './wrap';
import { Align } from './align';
import { Pad } from './pad';
import { Border } from './border';
import { Width } from './width';

export class Layout {
  static renderPage(text: string, cols: number, themeName: string): string {
    const lines = Wrap.wrapText(text, cols);
    const body = Width.max(lines);
    const centered = Pad.lines(lines, 1).map((l) => Align.center(l, body));
    const top = Border.top(body, themeName);
    const sides = centered.map((l) => Border.side(l, body, themeName));
    return [top, ...sides, top].join('\n');
  }
}
