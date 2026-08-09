function visibleLen(line) {
  return line.trimEnd().length;
}

function maxWidth(lines) {
  if (lines.length === 0) return 0;
  return Math.max(...lines.map(visibleLen));
}

export default { visibleLen, maxWidth };
