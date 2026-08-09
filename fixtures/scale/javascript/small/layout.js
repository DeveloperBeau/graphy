import wrap from './wrap.js';
import align from './align.js';
import pad from './pad.js';
import border from './border.js';
import width from './width.js';

function renderPage(text, cols, themeName) {
  const lines = wrap.wrapText(text, cols);
  const body = width.maxWidth(lines);
  const centered = pad.padLines(lines, 1).map((l) => align.alignCenter(l, body));
  const top = border.borderTop(body, themeName);
  const sides = centered.map((l) => border.borderSide(l, body, themeName));
  return [top, ...sides, top].join('\n');
}

export default { renderPage };
