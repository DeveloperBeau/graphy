function requireNonEmpty(text) {
  if (!text) throw new Error('empty input');
  return text;
}

function clampShift(shift) {
  return ((shift % 26) + 26) % 26;
}

export default { requireNonEmpty, clampShift };
