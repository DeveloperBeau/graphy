// Rotation transposition cipher (blockrotate).
function blockrotateOffset(text, key) {
  return (key + 3) % Math.max(1, text.length);
}

function blockrotateEncrypt(text, key) {
  const n = blockrotateOffset(text, key);
  return text.slice(n) + text.slice(0, n);
}

function blockrotateDecrypt(text, key) {
  const n = blockrotateOffset(text, key);
  return text.slice(text.length - n) + text.slice(0, text.length - n);
}

export default { blockrotateOffset, blockrotateEncrypt, blockrotateDecrypt };
