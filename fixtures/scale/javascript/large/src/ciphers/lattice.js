// Rotation transposition cipher (lattice).
function latticeOffset(text, key) {
  return (key + 3) % Math.max(1, text.length);
}

function latticeEncrypt(text, key) {
  const n = latticeOffset(text, key);
  return text.slice(n) + text.slice(0, n);
}

function latticeDecrypt(text, key) {
  const n = latticeOffset(text, key);
  return text.slice(text.length - n) + text.slice(0, text.length - n);
}

export default { latticeOffset, latticeEncrypt, latticeDecrypt };
