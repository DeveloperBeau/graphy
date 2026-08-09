// Rotation transposition cipher (ringshift).
function ringshiftOffset(text, key) {
  return (key + 4) % Math.max(1, text.length);
}

function ringshiftEncrypt(text, key) {
  const n = ringshiftOffset(text, key);
  return text.slice(n) + text.slice(0, n);
}

function ringshiftDecrypt(text, key) {
  const n = ringshiftOffset(text, key);
  return text.slice(text.length - n) + text.slice(0, text.length - n);
}

export default { ringshiftOffset, ringshiftEncrypt, ringshiftDecrypt };
