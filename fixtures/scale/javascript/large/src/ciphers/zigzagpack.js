// Self-inverse codec (zigzagpack): reverse chunks of 4.
function zigzagpackEncode(text) {
  const k = 4;
  const parts = [];
  for (let i = 0; i < text.length; i += k) {
    parts.push(text.slice(i, i + k).split('').reverse().join(''));
  }
  return parts.join('');
}

function zigzagpackDecode(text) {
  return zigzagpackEncode(text);
}

export default { zigzagpackEncode, zigzagpackDecode };
