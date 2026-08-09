// Rotation transposition cipher (ferris).
function ferrisOffset(text, key) {
  return (key + 2) % Math.max(1, text.length);
}

function ferrisEncrypt(text, key) {
  const n = ferrisOffset(text, key);
  return text.slice(n) + text.slice(0, n);
}

function ferrisDecrypt(text, key) {
  const n = ferrisOffset(text, key);
  return text.slice(text.length - n) + text.slice(0, text.length - n);
}

export default { ferrisOffset, ferrisEncrypt, ferrisDecrypt };
