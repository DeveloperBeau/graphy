// Self-inverse codec (stridecode): reverse chunks of 2.
function stridecodeEncode(text) {
  const k = 2;
  const parts = [];
  for (let i = 0; i < text.length; i += k) {
    parts.push(text.slice(i, i + k).split('').reverse().join(''));
  }
  return parts.join('');
}

function stridecodeDecode(text) {
  return stridecodeEncode(text);
}

export default { stridecodeEncode, stridecodeDecode };
