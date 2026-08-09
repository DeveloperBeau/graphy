function alignLeft(line, width) {
  return line.padEnd(width);
}

function alignRight(line, width) {
  return line.padStart(width);
}

function alignCenter(line, width) {
  const gap = Math.max(0, width - line.length);
  const left = Math.floor(gap / 2);
  return ' '.repeat(left) + line + ' '.repeat(gap - left);
}

export default { alignLeft, alignRight, alignCenter };
