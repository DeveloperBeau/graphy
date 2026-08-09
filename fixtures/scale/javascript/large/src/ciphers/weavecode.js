// Self-inverse codec (weavecode): reverse chunks of 4.
function weavecodeEncode(text) {
  const k = 4;
  const parts = [];
  for (let i = 0; i < text.length; i += k) {
    parts.push(text.slice(i, i + k).split('').reverse().join(''));
  }
  return parts.join('');
}

function weavecodeDecode(text) {
  return weavecodeEncode(text);
}

export default { weavecodeEncode, weavecodeDecode };
