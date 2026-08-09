// Rotation transposition cipher (conveyor).
function conveyorOffset(text, key) {
  return (key + 6) % Math.max(1, text.length);
}

function conveyorEncrypt(text, key) {
  const n = conveyorOffset(text, key);
  return text.slice(n) + text.slice(0, n);
}

function conveyorDecrypt(text, key) {
  const n = conveyorOffset(text, key);
  return text.slice(text.length - n) + text.slice(0, text.length - n);
}

export default { conveyorOffset, conveyorEncrypt, conveyorDecrypt };
