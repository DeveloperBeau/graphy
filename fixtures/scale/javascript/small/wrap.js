function wrapText(text, width) {
  const words = text.split(' ');
  const lines = [];
  let current = '';
  for (const word of words) {
    if (current.length + word.length + 1 > width) {
      lines.push(current.trim());
      current = '';
    }
    current += word + ' ';
  }
  if (current.trim()) lines.push(current.trim());
  return lines;
}

export default { wrapText };
