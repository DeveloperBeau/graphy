function toCodes(text) {
  return Array.from(text).map((ch) => ch.charCodeAt(0));
}

function fromCodes(codes) {
  return codes.map((c) => String.fromCharCode(((c % 256) + 256) % 256)).join('');
}

function xorStream(codes, keyCodes) {
  return codes.map((c, i) => c ^ keyCodes[i % keyCodes.length]);
}

export default { toCodes, fromCodes, xorStream };
