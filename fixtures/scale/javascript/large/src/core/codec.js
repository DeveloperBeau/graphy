function toHex(text) {
  return Array.from(text)
    .map((ch) => (ch.charCodeAt(0) % 256).toString(16).padStart(2, '0'))
    .join('');
}

function fingerprint(text) {
  let total = 0;
  for (const ch of text) total += ch.charCodeAt(0);
  return (total % 65536).toString(16).padStart(4, '0');
}

export default { toHex, fingerprint };
