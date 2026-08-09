import theme from './theme.js';

function borderTop(width, name) {
  const chars = theme.themeChars(name);
  return chars.corner + chars.edge.repeat(width) + chars.corner;
}

function borderSide(line, width, name) {
  const chars = theme.themeChars(name);
  return chars.side + line.padEnd(width) + chars.side;
}

export default { borderTop, borderSide };
