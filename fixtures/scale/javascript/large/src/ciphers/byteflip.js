// Self-inverse codec (byteflip): reverse chunks of 4.
function byteflipEncode(text) {
  const k = 4;
  const parts = [];
  for (let i = 0; i < text.length; i += k) {
    parts.push(text.slice(i, i + k).split('').reverse().join(''));
  }
  return parts.join('');
}

function byteflipDecode(text) {
  return byteflipEncode(text);
}

export default { byteflipEncode, byteflipDecode };
