function padLines(lines, count) {
  const blanks = Array.from({ length: count }, () => '');
  return [...blanks, ...lines, ...blanks];
}

function padWidth(lines, width) {
  return lines.map((line) => line.padEnd(width));
}

export default { padLines, padWidth };
