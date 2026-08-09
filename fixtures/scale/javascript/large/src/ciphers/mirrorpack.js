// Self-inverse codec (mirrorpack): reverse chunks of 3.
function mirrorpackEncode(text) {
  const k = 3;
  const parts = [];
  for (let i = 0; i < text.length; i += k) {
    parts.push(text.slice(i, i + k).split('').reverse().join(''));
  }
  return parts.join('');
}

function mirrorpackDecode(text) {
  return mirrorpackEncode(text);
}

export default { mirrorpackEncode, mirrorpackDecode };
