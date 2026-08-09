// Rotation transposition cipher (windmill).
function windmillOffset(text, key) {
  return (key + 1) % Math.max(1, text.length);
}

function windmillEncrypt(text, key) {
  const n = windmillOffset(text, key);
  return text.slice(n) + text.slice(0, n);
}

function windmillDecrypt(text, key) {
  const n = windmillOffset(text, key);
  return text.slice(text.length - n) + text.slice(0, text.length - n);
}

export default { windmillOffset, windmillEncrypt, windmillDecrypt };
