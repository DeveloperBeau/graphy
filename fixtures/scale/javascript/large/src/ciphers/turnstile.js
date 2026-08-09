// Rotation transposition cipher (turnstile).
function turnstileOffset(text, key) {
  return (key + 7) % Math.max(1, text.length);
}

function turnstileEncrypt(text, key) {
  const n = turnstileOffset(text, key);
  return text.slice(n) + text.slice(0, n);
}

function turnstileDecrypt(text, key) {
  const n = turnstileOffset(text, key);
  return text.slice(text.length - n) + text.slice(0, text.length - n);
}

export default { turnstileOffset, turnstileEncrypt, turnstileDecrypt };
