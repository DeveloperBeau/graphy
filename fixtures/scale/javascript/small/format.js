function toUpper(text) {
  return text.toUpperCase();
}

function repeat(ch, n) {
  return ch.repeat(n);
}

function underline(text) {
  return text + '\n' + repeat('-', text.length);
}

export default { toUpper, repeat, underline };
