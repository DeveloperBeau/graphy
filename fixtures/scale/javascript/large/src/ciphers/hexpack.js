// Self-inverse codec (hexpack): reverse chunks of 2.
function hexpackEncode(text) {
  const k = 2;
  const parts = [];
  for (let i = 0; i < text.length; i += k) {
    parts.push(text.slice(i, i + k).split('').reverse().join(''));
  }
  return parts.join('');
}

function hexpackDecode(text) {
  return hexpackEncode(text);
}

export default { hexpackEncode, hexpackDecode };
